import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/features/auth/presentation/providers/auth_provider.dart';
import 'package:kenryo_tankyu/features/auth/presentation/widgets/auth_app_bar.dart';
import 'package:kenryo_tankyu/features/auth/presentation/widgets/input_email.dart';
import 'package:kenryo_tankyu/features/auth/presentation/widgets/input_password.dart';


class CreatePassWordPage extends ConsumerWidget {
  const CreatePassWordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = ref.watch(authProvider).userName;
    return Scaffold(
      appBar: AuthAppBar(percent: 0.66),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top,
          child: Column(
            children: [
              const Spacer(flex: 1),
              Text('ようこそ $userName さん!',
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'アカウントを作成しましょう',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold)
                      ),
                      const SizedBox(height: 5),
                      InputEmail(ref.watch(authProvider).email!, false, false),
                      const SizedBox(height: 20),
                      const InputPassword(),
                      const SizedBox(height: 20),
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
