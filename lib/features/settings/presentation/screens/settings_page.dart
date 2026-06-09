import 'package:kenryo_tankyu/features/settings/presentation/widgets/delete_data_dialog.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/providers/user_archive_providers.dart';
import 'package:kenryo_tankyu/presentation/widget/error_dialog.dart';
import 'package:kenryo_tankyu/core/error/failures.dart';
import 'package:kenryo_tankyu/features/auth/domain/models/auth_failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import "package:kenryo_tankyu/core/constants/app_unique_value.dart";
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kenryo_tankyu/core/providers/firebase_providers.dart';
import 'package:kenryo_tankyu/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:kenryo_tankyu/features/auth/presentation/providers/auth_provider.dart';
import 'package:kenryo_tankyu/features/settings/presentation/providers/settings_providers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  // iOS APNs への登録も含めた権限リクエスト
                  final settings = await ref
                      .read(firebaseMessagingProvider)
                      .requestPermission();
                  debugPrint(
                      'Notification auth status: ${settings.authorizationStatus}');

                  final granted = settings.authorizationStatus ==
                          AuthorizationStatus.authorized ||
                      settings.authorizationStatus ==
                          AuthorizationStatus.provisional;

                  if (!granted) {
                    // 拒否されている場合はシステム設定へ誘導
                    if (context.mounted) {
                      _showPermissionDeniedDialog(context);
                    }
                    return;
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
              title: const Text('履歴の削除'),
              leading: const Icon(Icons.history),
              onTap: () => _showDeleteDataDialog(context, ref),
            ),
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
                            Navigator.of(context).pop();
                            await _deleteAccountWithReauth(context, ref);
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

  Future<void> _deleteAccountWithReauth(
      BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(authProvider.notifier).deleteAccount();
    } on RequiresRecentLogin {
      if (!context.mounted) return;
      final user = ref.read(authRepositoryProvider).currentUser;
      final isGoogle =
          user?.providerData.any((p) => p.providerId == 'google.com') ?? false;
      if (isGoogle) {
        await _reauthWithGoogleAndDelete(context, ref);
      } else {
        await _reauthWithPasswordAndDelete(context, ref);
      }
    } on Failure catch (e) {
      if (!context.mounted) return;
      showErrorDialog(context, e);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('予期せぬエラーが発生しました: $e')),
      );
    }
  }

  Future<void> _reauthWithGoogleAndDelete(
      BuildContext context, WidgetRef ref) async {
    try {
      final reauthenticated =
          await ref.read(authRepositoryProvider).reauthenticateWithGoogle();
      if (!context.mounted) return;
      if (!reauthenticated) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Googleサインインがキャンセルされました')),
        );
        return;
      }
      await ref.read(authProvider.notifier).deleteAccount();
    } on Failure catch (e) {
      if (!context.mounted) return;
      showErrorDialog(context, e);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('予期せぬエラーが発生しました: $e')),
      );
    }
  }

  Future<void> _reauthWithPasswordAndDelete(
      BuildContext context, WidgetRef ref) async {
    final passwordController = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('再認証が必要です'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('セキュリティのため、パスワードを入力してアカウント削除を続けてください。'),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'パスワード',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('削除する'),
          ),
        ],
      ),
    );
    if (confirmed != true) {
      passwordController.dispose();
      return;
    }
    final password = passwordController.text;
    passwordController.dispose();

    if (!context.mounted) return;
    try {
      final user = ref.read(authRepositoryProvider).currentUser;
      final email = user?.email ?? '';
      await ref
          .read(authRepositoryProvider)
          .reauthenticateWithEmailAndPassword(email: email, password: password);
      await ref.read(authProvider.notifier).deleteAccount();
    } on Failure catch (e) {
      if (!context.mounted) return;
      showErrorDialog(context, e);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('予期せぬエラーが発生しました: $e')),
      );
    }
  }

  Future<void> _showDeleteDataDialog(
      BuildContext context, WidgetRef ref) async {
    final repository = ref.read(userArchiveRepositoryProvider);

    final List<DateTime> historyDates;
    final List<({DateTime date, int bytes})> pdfEntries;
    try {
      historyDates = await repository.getAllHistorySavedDates();
      pdfEntries = await repository.getAllPdfCacheEntries();
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('データの取得に失敗しました')),
        );
      }
      return;
    }
    if (!context.mounted) return;

    final result = await showDialog<String?>(
      context: context,
      builder: (_) => DeleteDataDialog(
        historyDates: historyDates,
        pdfEntries: pdfEntries,
        onDeleteAllHistory: () async {
          await ref.read(historyControllerProvider.notifier).deleteAllHistory();
        },
        onDeleteHistoryBefore: (before) async {
          await ref
              .read(historyControllerProvider.notifier)
              .deleteHistoryBefore(before);
        },
        onDeleteAllPdf: () async {
          await ref.read(pdfCacheControllerProvider.notifier).deleteAll();
        },
        onDeletePdfBefore: (before) async {
          await ref
              .read(pdfCacheControllerProvider.notifier)
              .deleteBefore(before);
        },
      ),
    );

    if (result != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
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
