# 新しい探究アーカイブへの移行案内

## 表示

- ログイン前：案内カードをログインボタンの前に表示。小さい画面や文字拡大時はスクロールしてログインできる。
- ログイン後：ホームの挨拶の下、利用状況やおすすめ作品の前に同じカードを常設。
- カードの「移行とサービス終了について」から詳細を開く。閉じると元の画面に戻る。起動時に強制表示するダイアログは追加しない。
- 既存の認証・検索・PDF閲覧・お気に入り・履歴・通知・設定の処理は変更しない。案内表示にサーバーの案内データやDBへの書き込みは不要。

## カードの文面

Coming soon…

新しいWebアプリを準備しています

このアプリは2026年11月末でサービスを終了します。探究アーカイブは、新しいWebアプリとして生まれ変わります。公開時期やご利用方法は、学校の先生から改めてご案内します。

ボタン：移行とサービス終了について

## 詳細の文面

いつも探究アーカイブをご利用いただき、ありがとうございます。

探究アーカイブは、新しいWebアプリとして生まれ変わります。現在、公開に向けて準備を進めています。

このアプリは2026年11月末でサービスを終了します。終了までは、作品の検索・閲覧、お気に入り、履歴などの機能を引き続きご利用いただけます。

新しいWebアプリの公開時期やご利用方法は、学校の先生から改めてご案内します。公開まで、もうしばらくお待ちください。

お気に入り・履歴などのデータの取り扱いについても、詳細が決まり次第、学校の先生からご案内します。

## App Store Connect「このバージョンの最新情報」案

新しい探究アーカイブへの移行に関するお知らせを追加しました。

探究アーカイブは、新しいWebアプリとして生まれ変わります。これに伴い、本アプリは2026年11月末でサービスを終了します。終了までは、作品の検索・閲覧、お気に入り、履歴などの機能を引き続きご利用いただけます。

新しいWebアプリの公開時期やご利用方法、データの取り扱いについては、学校の先生から改めてご案内します。公開まで、もうしばらくお待ちください。

いつも探究アーカイブをご利用いただき、ありがとうございます。

## App Reviewのメモ案（審査担当者向け）

This update adds an informational notice about a planned transition to a new web app version of Tankyu Archive and the discontinuation of this native app at the end of November 2026. Teachers at the school will provide further information about the web app’s availability and how to access it. The current app remains functional; this update does not remove or disable existing features, including sign-in, work search, PDF viewing, favorites, and browsing history.

The notice appears on the sign-in screen and the home screen. Tapping “移行とサービス終了について” opens additional information, which can be dismissed with “閉じる”. The notice does not require an external app or website to continue using the existing features.

## 公開準備の追加変更

- バージョンを1.3.2へ更新。直前の公開版は1.3.1（ビルド17）。
- 旧報告フォームの管理用サービスアカウントをアプリへ同梱しないよう、アセット宣言と配信時の復元処理を削除。
- 報告フォームの内容は、Firebase認証付きの既存 `/api/reports` に送る。旧分類名を保持するため、報告種別は「その他」とし、フォームの全入力を本文に含める。管理室の報告一覧で確認する。共有API・DBの変更なし。
- 報告の送信上限は既存APIに合わせる。認証拒否や受付未完了を成功表示しない。

## 公開前に残る確認

- 新バージョンは1.3.2。配信ビルド番号はGitHub Actionsの実行番号を使用する。
- Appleの認証キー・署名証明書の有効性を確認する。
- 配信設定が指定するFlutter 3.41.9で、実際のiOSビルド・実機起動・ログイン後のホーム・既存の検索/PDF閲覧等を確認する。
- App Reviewのメモには、学校アカウントの制限と既存の審査用ログイン情報・手順を別途記載する。認証情報はこの文書に保存しない。
- 旧アプリの終了は2026年11月末。新版の公開日・データの引き継ぎ方法は未確定のため約束しない。学校の先生から案内する。
- 今回の案内は更新をインストールした利用者に表示される。旧版の利用を停止する機能や強制更新は追加していない。

この文書の作成時点では、アップロード・審査申請・公開は行っていない。
