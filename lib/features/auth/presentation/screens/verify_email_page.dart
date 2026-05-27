import 'package:kenryo_tankyu/core/providers/firebase_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import "package:kenryo_tankyu/core/constants/app_unique_value.dart";
import 'package:kenryo_tankyu/core/constants/feature/user_value.dart';
import 'package:kenryo_tankyu/features/auth/presentation/providers/auth_provider.dart';

class CheckEmailPage extends ConsumerWidget {
  const CheckEmailPage({super.key});

  String _displayEmail(WidgetRef ref) {
    // Firebase ユーザーのメールアドレスを正とする。フォーム状態より信頼性が高い。
    final fbEmail = ref.watch(authStateChangesProvider).asData?.value?.email;
    if (fbEmail != null) return fbEmail;
    // フォールバック: アプリ起動直後など stream 未受信時
    final auth = ref.watch(authProvider);
    if (auth.affiliation == Affiliation.developer) return auth.email ?? '';
    return '${auth.email ?? ''}@kenryo.ed.jp';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text('メール認証',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                Image.asset(appIcon, width: 100, height: 100),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('${_displayEmail(ref)}にメールを送信しました。',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left),
                        const SizedBox(height: 20),
                        const Text(
                            'メールに記載されたリンクをクリックして、アカウントを有効化してください。\nメールが届かない場合は、迷惑メールフォルダをご確認ください。'),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () => _resendVerifyEmail(context, ref),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15),
                            ),
                            child: const Text('確認メールを再送信する'),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () => _reload(context, ref),
                            child: const Text('確認した方はこちら'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _resendVerifyEmail(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(authProvider.notifier).sendVerifyEmail();
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('メールを再送しました。'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('メールの送信に失敗しました。'),
        ),
      );
    }
  }

  _reload(BuildContext context, WidgetRef ref) async {
    await ref.read(authProvider.notifier).reloadUser();
    // ログイン成功時にFCMトークンを取得
    final messaging = ref.read(firebaseMessagingProvider);
    try {
      String? fcmToken = await messaging.getToken();
      debugPrint('FCMトークン: $fcmToken');
    } catch (e) {
      debugPrint('FCMトークンの取得に失敗しました: $e');
    }
  }
}
