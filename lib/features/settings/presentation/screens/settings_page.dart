import 'package:kenryo_tankyu/features/auth/domain/models/auth_failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import "package:kenryo_tankyu/core/constants/app_unique_value.dart";
import 'package:kenryo_tankyu/core/providers/firebase_providers.dart';
import 'package:kenryo_tankyu/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:kenryo_tankyu/features/auth/presentation/providers/auth_provider.dart';
import 'package:kenryo_tankyu/features/settings/presentation/providers/settings_providers.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationAsync = ref.watch(notificationEnabledProvider);
    // ロード中も直前の値を保持することでトグルのスナップバックを防ぐ
    final notification = notificationAsync.value ?? false;
    final themeModeAsync = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('設定')),
      body: SingleChildScrollView(
        child: ListBody(
          children: [
            SwitchListTile(
              value: notification,
              onChanged: (bool value) async {
                if (value) {
                  final status = await Permission.notification.status;
                  debugPrint('Current notification status: $status');

                  if (status.isPermanentlyDenied ||
                      (status.isDenied && !status.isLimited)) {
                    // iOSで一度拒否されると request() ではダイアログが出ないことがあるため、状態を確認
                    final requestStatus =
                        await Permission.notification.request();
                    debugPrint('Notification request result: $requestStatus');

                    if (!requestStatus.isGranted &&
                        !requestStatus.isProvisional) {
                      if (context.mounted) {
                        _showPermissionDeniedDialog(context);
                      }
                      return;
                    }
                  }

                  // FCMトークンの取得を試みる（ブロックしない）
                  ref
                      .read(firebaseMessagingProvider)
                      .getToken()
                      .then((token) => debugPrint('FCM Token: $token'))
                      .catchError((e) => debugPrint('FCM Token Error: $e'));
                }

                try {
                  debugPrint('Updating notification setting to: $value');
                  await ref
                      .read(settingsProvider.notifier)
                      .setNotification(value);
                  debugPrint('Notification setting updated successfully');
                } catch (e) {
                  debugPrint('Error updating notification setting: $e');
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('設定の更新に失敗しました: $e')),
                    );
                  }
                }
              },
              secondary: const Icon(Icons.notifications_active_outlined),
              title: const Text('通知を受け取る'),
            ),
            ListTile(
              title: const Text('テーマ設定'),
              leading: const Icon(Icons.light_mode),
              trailing: themeModeAsync.when(
                data: (theme) => DropdownButton<ThemeMode>(
                  value: theme,
                  onChanged: (ThemeMode? value) {
                    if (value != null) {
                      ref.read(settingsProvider.notifier).setThemeMode(value);
                    }
                  },
                  items: const [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text('システムの設定'),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text('ライト'),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text('ダーク'),
                    ),
                  ],
                ),
                loading: () => const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                error: (err, stack) => const Text('エラー'),
              ),
            ),
            ListTile(
              title: const Text('アプリの情報'),
              leading: const Icon(Icons.info),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: appName,
                  applicationVersion: version,
                  applicationIcon: Image.asset(appIcon, width: 50, height: 50),
                );
              },
            ),
            ListTile(
              title: const Text('利用規約'),
              leading: const Icon(Icons.description),
              onTap: () {
                launchUrl(termsOfServiceLink);
              },
            ),
            ListTile(
              title: const Text('プライバシーポリシー'),
              leading: const Icon(Icons.privacy_tip),
              onTap: () {
                launchUrl(privacyPolicyLink);
              },
            ),
            ListTile(
              title: const Text('お問い合わせ'),
              leading: const Icon(Icons.contact_support),
              onTap: () {
                launchUrl(contactFormLink);
              },
            ),
            developer_mode
                ? ListTile(
                    title: const Text('開発者モード'),
                    leading: const Icon(Icons.developer_mode),
                    onTap: () {
                      context.go('/testSelect/aoi');
                    },
                  )
                : const SizedBox(),
            ListTile(
              title: const Text('ログアウト'),
              leading: const Icon(Icons.logout),
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      final profileName = ref
                              .watch(authRepositoryProvider)
                              .currentUser
                              ?.displayName ??
                          'ゲスト';
                      return AlertDialog(
                          title: Text('待って！ $profileNameさん'),
                          content: const Text('ログアウトしてよろしいですか？'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('いいえ'),
                            ),
                            TextButton(
                              onPressed: () async {
                                await ref.read(authProvider.notifier).signOut();
                              },
                              child: const Text('はい'),
                            ),
                          ]);
                    });
              },
            ),
            ListTile(
              title: const Text('アカウント削除'),
              leading: const Icon(Icons.delete),
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    final profileName = ref
                            .watch(authRepositoryProvider)
                            .currentUser
                            ?.displayName ??
                        'ゲスト';
                    return AlertDialog(
                      title: Text('待って！ $profileNameさん'),
                      content: const Text('アカウントを削除してよろしいですか？'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('いいえ'),
                        ),
                        TextButton(
                          onPressed: () async {
                            try {
                              await ref
                                  .read(authProvider.notifier)
                                  .deleteAccount();
                              if (!context.mounted) return;
                              Navigator.of(context).pop();
                            } on AuthFailure catch (e) {
                              if (e is RequiresRecentLogin) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('再認証が必要です。再度ログインしてください。'),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('エラーが発生しました: $e'),
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text('はい'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showPermissionDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('通知が許可されていません'),
        content: const Text('通知を受け取るには、システム設定から通知を許可してください。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () {
              openAppSettings();
              Navigator.pop(context);
            },
            child: const Text('設定を開く'),
          ),
        ],
      ),
    );
  }
}
