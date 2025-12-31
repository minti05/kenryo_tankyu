//バージョンやアプリ名など、アプリ全体の固有の値を管理するファイル

//バージョンアップデートの時にやること
//1. pubspec.yamlのversionを変更
//2. lib/core/constants/app_unique_value.dartのversionを変更
//ターミナルで以下を実行
//flutter pub get
//flutter build ios

const String version = '1.1.1';

//Module cloud_firestore not foundになる場合の対処法
//1. Xcodeでios/Runner.xcworkspaceを開く
/*
cd ios
rm -rf Pods
rm Podfile.lock Podfile
flutter run
*/

const bool developer_mode = false;
const String appName = '探究アーカイブ';
const String appIcon = 'assets/images/app_icon.png';

// 利用規約やプライバシーポリシーのリンク 更新時に以下を変更
final termsOfServiceLink =
    Uri.parse('https://sites.google.com/view/tankyu-terms-of-service');
final privacyPolicyLink =
    Uri.parse('https://sites.google.com/view/tankyu-privacy-policy');
final contactFormLink = Uri.parse('https://forms.gle/xUXX88MJ5fLsVtAk9');
