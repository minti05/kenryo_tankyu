import 'package:kenryo_tankyu/features/auth/data/repositories/user_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kenryo_tankyu/features/auth/presentation/providers/auth_provider.dart';
import 'package:kenryo_tankyu/features/auth/presentation/widgets/auth_app_bar.dart';
import 'package:kenryo_tankyu/features/auth/presentation/widgets/input_email.dart';
import 'package:kenryo_tankyu/features/auth/presentation/widgets/input_year.dart';

class VerifyNamePage extends ConsumerWidget {
  const VerifyNamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    return Scaffold(
        appBar: AuthAppBar(percent: 0.33),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            child: Column(
              children: [
                const Spacer(flex: 1),
                Text('縣陵生であることを確認',
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('所属を選択',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        const InputYear(),
                        const SizedBox(height: 20),
                        Text('メールアドレスを入力',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        InputEmail(ref.read(authProvider).email ?? '', true, false),
                        Consumer(builder: (context, ref, child) {
                          final limit = auth.limit;
                          switch (limit) {
                            case >= 5:
                              return const SizedBox();
                            default:
                              return Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: limit > 0
                                    ? Text(
                                        'メールアドレスが存在しないか、所属が間違っています。もう一度入力してください。\n残り$limit回',
                                        style:
                                            const TextStyle(color: Colors.red))
                                    : Text(
                                        '試行回数の上限に達しました。\nもう一度アプリを落としやり直してください。\nまたは問い合わせる',
                                        style:
                                            const TextStyle(color: Colors.red)),
                              );
                          }
                        }),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: auth.email != null &&
                          auth.affiliation != null &&
                          auth.limit > 0
                      ? () => _verifyName(context, ref)
                      : null,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                  child: const Text('認証する'),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ));
  }

  _verifyName(BuildContext context, WidgetRef ref) async {
    final auth = ref.watch(authProvider);
    final notifier = ref.read(authProvider.notifier);
    final emailAddress = '${auth.email}@kenryo.ed.jp';
    
    final userData = await ref.read(userRepositoryProvider).verifyUser(
      email: emailAddress, 
      affiliation: auth.affiliation?.name ?? ''
    );
    
    if (userData != null) {
        final userName = userData['name'];
        //登録済みかどうかを確認。登録済みならログイン画面への誘導をする。未登録ならアカウント作成画面へ。
        final alreadyRegistered = userData['registered'];
        if (alreadyRegistered) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Column(
                children: [
                  const Text('このメールアドレスは既に登録されています'),
                  ElevatedButton(
                      onPressed: () => context.go('/welcome/login'),
                      child: const Text('ログイン画面に移動')),
                ],
              ),
            ),
          );
        } else {
          debugPrint("ここまで来てるよー");
          notifier.changeUserName(userName);
          context.go('/welcome/verify_name/create_password');
        }
      } else {
        notifier.decrementLimit();
      }
  }
  }

