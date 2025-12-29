import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/features/auth/presentation/providers/auth_provider.dart';
import 'package:kenryo_tankyu/features/auth/presentation/widgets/auth_app_bar.dart';
import 'package:kenryo_tankyu/features/auth/presentation/widgets/input_email.dart';
import 'package:kenryo_tankyu/features/auth/presentation/widgets/input_password_for_login.dart';

class LoginPage extends ConsumerWidget {
  final bool isDeveloper;
  const LoginPage({required this.isDeveloper, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AuthAppBar(percent: 1),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top,
          child: Column(
            children: [
              const Spacer(flex: 1),
              Text('ログイン',
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
                      Text('メールアドレスを入力',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      InputEmail(ref.watch(authProvider).email ?? '', true, isDeveloper ),
                      const SizedBox(height: 20),
                      Text('パスワードを入力',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      InputPasswordForLogin(
                          ref.watch(authProvider).password ?? '', isDeveloper),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
