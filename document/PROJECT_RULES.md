# 開発ガイドライン (Development Guidelines)

このドキュメントは、本プロジェクト（Kenryo Tankyu）の開発におけるアーキテクチャ、ディレクトリ構成、およびコーディング規約を定義します。
特に、**AIエージェント**がコードベースを理解し、統一されたスタイルで実装を行うための「ルールブック」として機能することを意図しています。

---

## 1. ディレクトリ構成 (Directory Structure)

本プロジェクトは **Feature-First Architecture** を採用しています。機能（Feature）ごとにフォルダを分割し、その中にClean Architectureのレイヤーを配置します。

### ルート構造 (`lib/`)
```
lib/
├── core/               # アプリ全体で共有される汎用的なロジック・定数
│   ├── constants/      # 定数定義 (featureごとの定義もここに集約する場合あり)
│   ├── di/             # 依存注入の設定 (DIコンテナの初期化など)
│   ├── providers/      # アプリケーションスコープのProvider (Firebase, SharedPrefsなど)
│   ├── router/         # ルーティング定義 (GoRouterなど)
│   ├── theme/          # テーマ定義 (色、フォントなど)
│   └── utils/          # ユーティリティ関数
├── features/           # 機能ごとのモジュール
│   ├── auth/           # 認証機能
│   ├── search/         # 検索機能
│   ├── settings/       # 設定画面
│   ├── user_archive/   # お気に入り・履歴
│   ├── ...             # その他機能
│   └── (feature_name)/
│       ├── data/       # データ層 (RepositoryImpl, DataSource, Models)
│       ├── domain/     # ドメイン層 (Repository Interface, Entities, UseCases)
│       └── presentation/ # プレゼンテーション層 (Screens, Widgets, Providers)
├── presentation/       # 共通またはアプリ全体のUI (MainPage, CommonWidgets)
│   ├── screens/        # アプリの基盤となる画面 (BottomNavigationの親画面など)
│   └── widget/         # アプリ全体で使い回す汎用Widget
└── main.dart           # エントリーポイント
```

### Feature内部構造 (`lib/features/<name>/`)
各Featureディレクトリは以下の構成を順守してください。

```
<feature_name>/
├── data/
│   ├── datasources/    # 外部データソースへのアクセス (API, DB)
│   ├── models/         # データモデル (DTO, JSON変換)
│   └── repositories/   # Repositoryの実装クラス (RepositoryImpl)
├── domain/
│   ├── models/         # ドメインモデル (エンティティ)
│   ├── repositories/   # Repositoryのインターフェース (abstract class)
│   └── usecases/       # (Optional) 複雑なビジネスロジックがあれば配置
└── presentation/
    ├── providers/      # Riverpod Provider / Notifier
    ├── screens/        # 画面Widget (Scaffoldを持つことが多い)
    └── widgets/        # その機能専用の部品Widget
```

---

## 2. 依存性注入とデータフロー (Dependency Injection & Data Flow)

詳細なシーケンスは `document/DI_STRUCTURE.md` を参照してください。ここではルールを定義します。

### 基本ルール (The Golden Rules)
1.  **Strict Layering**: 依存方向を一方向に保つ。
    `Presentation` -> `Domain` <- `Data` (Dependency Inversion)
    `Data` -> `DataSource` -> `External(Firebase/API)`
2.  **No Direct Access**: Presentation層（Widget/Controller）から `FirebaseFirestore` や `FirebaseAuth` などの外部SDKを直接呼んではいけない。必ず **Repository** を経由すること。
3.  **DataSource分離**: Repository内で外部サービスを直接インスタンス化せず、 **DataSource** クラスを作成して注入する。
    *   NG: `RepositoryImpl` が `FirebaseFirestore.instance` を直接使う。
    *   OK: `RepositoryImpl` は `RemoteDataSource` を持ち、そこに委譲する。

### Riverpod Provider構成命名規則

| 種別 | ファイル名/変数名 | 役割 | 依存先 |
| :--- | :--- | :--- | :--- |
| **DataSource** | `*_data_source.dart`<br>`*DataSourceProvider` | 生のデータアクセス。<br>FirestoreやAPIを直接叩く。 | External Services<br>(Firebase, Prefs) |
| **Repository** | `*_repository_impl.dart`<br>`*RepositoryProvider` | ドメイン層のIF実装。<br>DataSourceからデータを取得しDomainモデルに変換。 | DataSource |
| **Notifier/Provider** | `*_provider.dart`<br>`*NotifierProvider` | UI状態管理。<br>Repositoryを呼んでStateを更新する。 | Repository |

---

## 3. コーディング規約 (Coding Standards for AI)

AIがコードを生成・修正する際は以下のルールに従ってください。

### ファイル作成
*   **Barrel Files (export一覧) の禁止**: `models.dart` や `repositories.dart` のような、単にexportするだけのファイルは作成しない（既存のものは順次廃止）。ファイルの実体を直接importすることで依存関係を明確にする。
*   **ファイル名**: スネークケース (`user_repository.dart`).
*   **クラス名**: パスカルケース (`UserRepository`).

### 実装パターン
*   **Riverpod Generator**: 可能な限り `riverpod_annotation` を使用してProviderを生成する。
    ```dart
    @riverpod
    UserRepository userRepository(Ref ref) {
      final dataSource = ref.watch(userDataSourceProvider);
      return UserRepositoryImpl(dataSource);
    }
    ```
*   **Import順序**:
    1.  Dart/Flutter built-in (`dart:io`, `package:flutter/...`)
    2.  3rd party (`package:riverpod/...`, `package:firebase_...`)
    3.  Internal components (`package:kenryo_tankyu/...`)
    *   **相対パス禁止**: 必ず絶対パス (`package:kenryo_tankyu/...`) を使用する。

### コミットメッセージ
*   AIがGit操作を行う場合、必ず日本語で記述する。
*   形式: `[対象機能/ファイル] 変更内容の要約`
    *   例: `[Auth] AuthRepositoryにDataSourceを導入しDI構成を修正`

---

## 4. Workflows

### 新機能追加フロー
1.  `domain/repositories` にインターフェースを定義。
2.  `domain/models` にモデルを定義。
3.  `data/datasources` にデータソースを作成 (Fake/Mockから始めても良い)。
4.  `data/repositories` に実装クラスを作成。
5.  `presentation/providers` にProviderを作成。
6.  UI実装。

### リファクタリングフロー
1.  既存コードが上記「依存フロー」に違反していないかチェック。
2.  違反（例: UIでFirestoreを直叩き）があれば、DataSource/Repositoryを作成してロジックを移動。
3.  テスト（または動作確認）を行う。

以上
