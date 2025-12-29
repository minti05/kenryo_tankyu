import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kenryo_tankyu/features/auth/presentation/providers/auth_provider.dart';
import 'package:kenryo_tankyu/features/auth/presentation/widgets/auth_app_bar.dart';
import 'package:kenryo_tankyu/features/auth/presentation/widgets/input_email.dart';


class ResetPasswordPage extends ConsumerWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final confirmVerifiedEmail = auth.confirmVerifyEmail;
    final email = auth.email;
    return Scaffold(
      appBar: AuthAppBar(percent: 1),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top,
          child: Column(
            children: [
              const Spacer(flex: 1),
              Text('パスワードをリセット',
                  style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold)),
              Card(
                margin: const EdgeInsets.all(20),
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
                       Text('メールアドレスを入力',style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      InputEmail(ref.watch(authProvider).email ?? '', true, false),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                            onPressed: email != null && email.isNotEmpty
                                ? () => _sendResetMail(context,ref, email)
                                : null,
                            child: const Text('リセットメールを送信')),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              confirmVerifiedEmail
                  ? ElevatedButton(
                      onPressed: () =>
                          context.go('/welcome/login'),
                      child: const Text('ログインし直す'))
                  : const SizedBox(),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  Future _sendResetMail(BuildContext context,WidgetRef ref, String email) async {
    try {
      await ref.read(authProvider.notifier).sendPasswordResetEmail(email);
      ref.read(authProvider.notifier).changeVerifyEmail();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              children: [
                const Text('ユーザーが見つかりませんでした'),
                ElevatedButton(
                    onPressed: () => context.go('/welcome'),
                    child: const Text('アカウントを新規作成する')),
              ],
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('エラーが発生しました。${e.code}'),
          ),
        );
      }
    }
  }
}
