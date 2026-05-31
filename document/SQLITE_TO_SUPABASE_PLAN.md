# SQLite → Supabase 移行計画

## Context

閲覧履歴・お気に入り・検索履歴・通知既読状態をSupabaseへ移行する。
別端末ログイン時の同期と、スキーマ変更時の柔軟な対応が目的。

**確定方針:**
- Auth: Firebase UID を `user_id TEXT` として使用。RLS無効、アプリレベルでフィルタ。
- 既存SQLiteデータの移行: なし（移行後から新規積み上げ）
- PDFキャッシュ（works_pdf.db）: SQLiteのまま継続

---

## Supabaseの無料枠（認識確認）

実際の無料枠:
- DBサイズ: 500MB（累積ストレージ）
- 帯域幅（Egress）: 5GB/月（≒167MB/日平均）
- APIリクエスト数: 制限なし

学校規模（数百人・数百件）なら通常問題ない。

---

## Supabaseテーブル設計

### 1. `favorites`

```sql
CREATE TABLE favorites (
  user_id     TEXT        NOT NULL,
  document_id INTEGER     NOT NULL,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY (user_id, document_id)
);
CREATE INDEX idx_favorites_user_id ON favorites(user_id);
```

### 2. `browsing_history`

```sql
CREATE TABLE browsing_history (
  user_id       TEXT        NOT NULL,
  document_id   INTEGER     NOT NULL,
  title         TEXT        NOT NULL,
  author        TEXT        NOT NULL,
  category1     TEXT        NOT NULL,
  sub_category1 TEXT        NOT NULL,
  category2     TEXT        NOT NULL,
  sub_category2 TEXT        NOT NULL,
  enter_year    INTEGER     NOT NULL,
  event_name    TEXT        NOT NULL,
  course        TEXT        NOT NULL,
  likes         INTEGER     NOT NULL DEFAULT 0,
  exists_slide  BOOLEAN     NOT NULL DEFAULT FALSE,
  exists_report BOOLEAN     NOT NULL DEFAULT FALSE,
  exists_thesis BOOLEAN     NOT NULL DEFAULT FALSE,
  exists_poster BOOLEAN     NOT NULL DEFAULT FALSE,
  viewed_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY (user_id, document_id)
);
CREATE INDEX idx_browsing_history_user_id ON browsing_history(user_id);
```

#### INSERT vs UPDATE の切り分け

「同じ作品を再び開いた」かどうかはアプリ側でキャッシュ（またはgetHistory結果）から判断できる。

| ケース | 操作 | 送信内容 | 転送量 |
|---|---|---|---|
| 初回閲覧 | INSERT（全フィールド） | 全フィールド | ~300B |
| 再閲覧 | UPDATE viewed_at のみ | viewed_at のみ | ~50B |

```dart
// DataSource実装イメージ
Future<void> recordView(String userId, Searched work) async {
  final existing = await supabase
      .from('browsing_history')
      .select('document_id')
      .eq('user_id', userId)
      .eq('document_id', work.documentID)
      .maybeSingle();

  if (existing == null) {
    // 初回: 全フィールドINSERT
    await supabase.from('browsing_history').insert({
      'user_id': userId,
      ...work.toSupabase(),
      'viewed_at': DateTime.now().toIso8601String(),
    });
  } else {
    // 再閲覧: viewed_atのみUPDATE
    await supabase
        .from('browsing_history')
        .update({'viewed_at': DateTime.now().toIso8601String()})
        .eq('user_id', userId)
        .eq('document_id', work.documentID);
  }
}
```

> **注意:** `existing` の select は主キー照合なので高速（インデックス効く）。

#### `likes` の陳腐化対策（詳細画面で更新）

閲覧履歴一覧では `likes` を表示しない。
**作品詳細画面を開いたとき**に以下のフローを実行する:

```
1. 閲覧履歴から古い値で即時表示（画面をブロックしない）
2. viewed_at が 90日以上前 → バックグラウンドでFirestoreから最新作品を取得
3. 取得完了まで画面下部にスナックバー「データが古いため更新しています...」を表示
4. 取得完了後: 画面全体をUI更新 + Supabaseの browsing_history.likes も更新（タイトルなども変わっていた場合は全部更新）
5. 90日以内 → 何もしない（Firestoreへのリクエストなし）
```

```dart
// searched_provider.dart での実装イメージ
Future<void> _refreshLikesIfStale(int documentId, DateTime viewedAt) async {
  if (DateTime.now().difference(viewedAt) < const Duration(days: 90)) return;

  state = state.copyWith(isRefreshing: true);  // スナックバー表示トリガー
  try {
    final latest = await firestoreDataSource.getWork(documentId);
    //ここはlikesしか変わっていないかそれ以外も変わっているか条件分岐が必要
    state = state.copyWith(
      searched: state.searched.copyWith(likes: latest.likes),
      isRefreshing: false,
    );
    unawaited(historyDataSource.updateLikes(userId, documentId, latest.likes));
  } catch (_) {
    state = state.copyWith(isRefreshing: false);
  }
}
```

---

### 3. `search_history`

```sql
CREATE TABLE search_history (
  id             BIGSERIAL   PRIMARY KEY,
  user_id        TEXT        NOT NULL,
  category       TEXT        NOT NULL DEFAULT '',
  sub_category   TEXT        NOT NULL DEFAULT '',
  enter_year     INTEGER     NOT NULL DEFAULT 0,
  event_name     TEXT        NOT NULL DEFAULT '',
  course         TEXT        NOT NULL DEFAULT '',
  search_word    TEXT        NOT NULL DEFAULT '',
  number_of_hits INTEGER     NOT NULL DEFAULT 0,
  searched_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (user_id, category, sub_category, enter_year, event_name, course, search_word)
);
CREATE INDEX idx_search_history_user_id ON search_history(user_id);
```

---

### 4. `notification_reads`

通知コンテンツはFirestoreから取得しSQLiteにキャッシュする方式を維持。
既読状態だけSupabaseで端末間同期。

```sql
CREATE TABLE notification_reads (
  user_id         TEXT        NOT NULL,
  notification_id TEXT        NOT NULL,
  read_at         TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY (user_id, notification_id)
);
CREATE INDEX idx_notification_reads_user_id ON notification_reads(user_id);
```

---

## Riverpodキャッシュ戦略

### 初期化タイミング（全キャッシュ共通）

`authStateChanges` が `User` を流した瞬間（= ログイン確定後）に全キャッシュを initialize する。
これにより「起動時にログイン済み」「起動後にログイン」の両方をカバーできる。

### いいね一覧キャッシュ

```dart
@riverpod
class FavoriteIdsCache extends _$FavoriteIdsCache {
  Set<int> build() => {};

  Future<void> initialize(String userId) async {
    final rows = await supabase
        .from('favorites').select('document_id').eq('user_id', userId);
    state = rows.map<int>((r) => r['document_id'] as int).toSet();
  }

  void add(int id) => state = {...state, id};
  void remove(int id) => state = state.difference({id});
}
```

`search_repository_impl.dart` の `Searched.fromAlgolia(object, false)` →
`Searched.fromAlgolia(object, ref.read(favoriteIdsCacheProvider).contains(id))`
→ 検索結果一覧でもハートアイコンが正しく表示される（現状バグの解消も兼ねる）

### 通知既読キャッシュ

```dart
@riverpod
class ReadNotificationIds extends _$ReadNotificationIds {
  Set<String> build() => {};

  Future<void> initialize(String userId) async {
    final rows = await supabase
        .from('notification_reads').select('notification_id').eq('user_id', userId);
    state = rows.map<String>((r) => r['notification_id'] as String).toSet();
  }

  Future<void> markAsRead(String userId, String notificationId) async {
    state = {...state, notificationId};
    unawaited(supabase.from('notification_reads').upsert(
      {'user_id': userId, 'notification_id': notificationId},
    ));
  }
}
```

SQLiteの `notification` テーブルは引き続きコンテンツキャッシュとして使う。
`isRead` フィールドはSQLiteから削除し、`ReadNotificationIds` キャッシュで判定する。

---

## 変更が必要なファイル一覧

| ファイル | 変更内容 |
|---|---|
| `pubspec.yaml` | `supabase_flutter` を追加 |
| `lib/core/providers/` | Supabaseクライアント提供Providerを追加 |
| `lib/features/user_archive/data/datasources/searched_history_local_data_source.dart` | Supabase版に置き換え（favorites + browsing_history） |
| `lib/features/search/data/datasources/search_history_data_source.dart` | Supabase版に置き換え（search_history） |
| `lib/features/notification/data/datasources/notification_db.dart` | `isRead` フィールドを削除、コンテンツキャッシュのみに |
| `lib/features/user_archive/data/repositories/user_archive_repository_impl.dart` | DataSourceをSupabase版に差し替え |
| `lib/features/user_archive/presentation/providers/user_archive_providers.dart` | `FavoriteIdsCache` Providerを追加 |
| `lib/features/auth/presentation/providers/auth_provider.dart` | ログイン確定時に各キャッシュの `initialize()` を呼ぶ |
| `lib/features/search/data/repositories/search_repository_impl.dart` | `isFavorite` をキャッシュから解決 |
| `lib/features/notification/presentation/providers/` | `ReadNotificationIds` Providerを追加 |
| `lib/features/research_work/presentation/providers/searched_provider.dart` | likes陳腐化チェック・更新ロジックを追加 |

削除するSQLiteDB: `searched_history.db`、`search_history.db`

---

## アップデート時のユーザー対応

### データ消失について

移行しない方針のため、既存ユーザーがアップデートすると閲覧履歴・お気に入り・検索履歴がリセットされる。

### 必要な対応

**リリースノート（App Store / Google Play）に明記:**
> 今回のアップデートで、閲覧履歴・お気に入り・検索履歴が端末間で同期されるようになりました。
> これに伴い、アップデート前の履歴・お気に入りデータはリセットされます。

**アプリ内: 初回起動時のダイアログ:**
- `SharedPreferences` にバージョンフラグを保存し、アップデート後の初回起動を検知
- 「端末間同期に対応しました。以前の履歴はリセットされています」と表示

**コード: 旧SQLiteファイルの削除処理（main.dart で最初に実行）:**
```dart
Future<void> migrateLegacyDb() async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'supabase_migrated_v1';
  if (prefs.getBool(key) == true) return;

  final dbPath = await getDatabasesPath();
  for (final name in ['searched_history.db', 'search_history.db']) {
    final file = File(join(dbPath, name));
    if (await file.exists()) await file.delete();
  }
  await prefs.setBool(key, true);
}
```

---

## Claude Codeセッション分割戦略

### なぜ分割が必要か

変更ファイル10+・新規テーブル4・新規Provider3〜4つと規模が大きい。
1セッションで実装するとコンテキスト圧縮が入り、前半で書いたコードと後半の実装の整合性が崩れるリスクがある。

### 推奨: PR単位で6セッションに分割

各セッションは独立して完結できる単位にする。

---

#### セッション① `feat/supabase-init`
**目的:** Supabase導入・テーブル作成・クライアントProvider追加

作業内容:
- Supabaseプロジェクト作成（コンソール操作）
- `pubspec.yaml` に `supabase_flutter` 追加
- 上記4テーブルをSQLで作成（Supabaseコンソール）
- `lib/core/providers/supabase_provider.dart` 追加
- `main.dart` に `Supabase.initialize()` 追加

**セッション開始時のCLAUDE.mdへの補足指示（セッション冒頭に伝えること）:**
> Supabaseを新規導入する。`supabase_url` と `supabase_anon_key` は `.env` から読む想定で実装すること。テーブルはすでに作成済み。RLSは無効。Firebase Authは既存のまま維持し、Supabase Authは使わない。

---

#### セッション② `feat/supabase-favorites`
**目的:** お気に入りのSupabase移行 + 検索結果のisFavorite修正

作業内容:
- `SearchedHistoryLocalDataSource` の favorites メソッドをSupabase版に置き換え
- `FavoriteIdsCache` Riverpod Provider を追加
- `auth_provider.dart` でログイン確定時に `FavoriteIdsCache.initialize()` を呼ぶ
- `search_repository_impl.dart` の `fromAlgolia(object, false)` をキャッシュ参照に修正
- Firestoreの `likes` インクリメント処理は現状維持

**セッション開始時に伝えること:**
> セッション①が完了していてSupabaseクライアントProviderが使える状態。`searched_history.db` の favorites 関連メソッドをSupabase版に差し替える。SQLiteの `isFavorite` 列はまだ残っていてよい（セッション⑥で削除）。

---

#### セッション③ `feat/supabase-browsing-history`
**目的:** 閲覧履歴のSupabase移行

作業内容:
- `SearchedHistoryLocalDataSource` の history メソッドをSupabase版に置き換え
- INSERT/UPDATEの切り分けロジック実装
- `UserArchiveRepositoryImpl` の差し替え
- `searched_provider.dart` に likes 陳腐化チェック・更新ロジックを追加
- 詳細画面の「更新しています...」スナックバー実装

**セッション開始時に伝えること:**
> セッション②完了済み。今回は browsing_history テーブルへの読み書き。初回閲覧はINSERT・再閲覧はviewed_atのみUPDATEで切り分ける。likes陳腐化は90日以上前のレコードを詳細画面表示時にFirestoreから取得して更新する。

---

#### セッション④ `feat/supabase-search-history`
**目的:** 検索履歴のSupabase移行

作業内容:
- `SearchHistoryDataSource` をSupabase版に置き換え
- 検索履歴用 `AsyncNotifier` Provider（起動時1回取得・キャッシュ）
- UNIQUE制約を活かしたupsert実装

**セッション開始時に伝えること:**
> セッション①②③が完了済み。今回は `search_history` テーブルへの移行のみ。`search_history_data_source.dart` をSupabase版に差し替え、Riverpodキャッシュを追加する。

---

#### セッション⑤ `feat/supabase-notification-reads`
**目的:** 通知既読状態のSupabase移行

作業内容:
- `ReadNotificationIds` Riverpod Provider を追加
- `auth_provider.dart` でログイン確定時に `ReadNotificationIds.initialize()` を呼ぶ
- `notification_db.dart` から `isRead` フィールドを削除（DBバージョンをインクリメント）
- 通知一覧・詳細画面の `isRead` 判定を `ReadNotificationIds` キャッシュから行うよう修正

**セッション開始時に伝えること:**
> セッション①〜④完了済み。今回は通知既読管理をSupabaseへ移行する。通知コンテンツはFirestore→SQLiteキャッシュの構成はそのまま維持し、isRead状態だけをSupabaseに持つ。notification_dbのバージョンを上げてisRead列を削除するマイグレーションが必要。

---

#### セッション⑥ `feat/supabase-cleanup`
**目的:** 旧SQLite資産の削除・アップデート対応コードの追加

作業内容:
- 旧SQLiteファイル削除処理（`migrateLegacyDb()`）を `main.dart` に追加
- アップデート初回起動時のダイアログ実装
- `searched_history.db` / `search_history.db` に関連する DataSource・Repositoryの残骸を削除
- `flutter analyze` + `dart format` で最終確認

**セッション開始時に伝えること:**
> セッション①〜⑤完了済み。今回は旧SQLiteコードの削除と、アップデート時のユーザー対応（初回起動ダイアログ + 旧DBファイル削除処理）を実装する。

---

### セッションをまたぐ引き継ぎのコツ

- 各PRをmainにマージしてから次のセッションを始める
- セッション開始時に「前提条件（何が完了しているか）」を上記の文言で伝える
- `git log --oneline -5` の結果を最初に貼ると、Claudeが現状を誤解しにくい
- 迷ったら `flutter analyze` を走らせて型エラーがないか確認してから次のセッションへ
