import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:kenryo_tankyu/core/constants/app_unique_value.dart";

class WelcomePage extends ConsumerWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
          child: Column(
            children: [
              const Spacer(flex: 1),
              Text(
                '縣陵探究アーカイブ',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Image.asset(appIcon, width: 100),
              const SizedBox(height: 10),
              Text(
                  'このアプリは松本県ケ丘高等学校に在籍する生徒および職員が利用できる探究活動サポートアプリです。\n生徒のプライバシー保護のため、他の方はご利用いただけませんのでご了承ください。',
                  style: Theme.of(context).textTheme.bodySmall!),
              const Spacer(flex: 1),
              const Text('初めてアプリを使う方は'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _showDialog(false, context, ref),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text('新規登録'),
              ),
              const SizedBox(height: 20),
              Text('既に登録済みの方は'),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () => _showDialog(true, context, ref),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text('ログイン'),
              ),
              Spacer(flex: 2),
              Text('Version: $version'),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: 'デベロッパーとしてログイン',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.blue,
                      ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.push('/welcome/login', extra: true);
                    },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showDialog(bool isLogin, BuildContext context, WidgetRef ref) {
    final title = isLogin ? 'ログイン' : '新規登録';
    final route = isLogin ? '/welcome/login' : '/welcome/verify_name';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('このアプリは、\n松本県ヶ丘高校の生徒および職員がご利用できます。',
              style: Theme.of(context).textTheme.titleLarge),
          content: SingleChildScrollView(
            child: Column(
              children: [
                CheckboxListTile(
                  selectedTileColor: Colors.transparent,
                  controlAffinity: ListTileControlAffinity.leading,
                  fillColor: WidgetStateProperty.all(Colors.transparent),
                  checkColor: Theme.of(context).unselectedWidgetColor,
                  title: Text(
                    '私は上記に該当します。',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  value: true,
                  onChanged: (value) => null,
                ),
                _checkBox('利用規約', termsOfServiceLink, context),
                _checkBox('プライバシーポリシー', privacyPolicyLink, context),
              ],
            ),
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.push(route, extra: false);
                },
                child: Text('同意して$title'),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _checkBox(String text, Uri uri, BuildContext context) {
    return CheckboxListTile(
      fillColor: WidgetStateProperty.all(Colors.transparent),
      checkColor: Theme.of(context).unselectedWidgetColor,
      controlAffinity: ListTileControlAffinity.leading,
      value: true,
      onChanged: (value) => null,
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: text,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.blue),
              recognizer: TapGestureRecognizer()..onTap = () => launchUrl(uri),
            ),
            TextSpan(
              text: 'に同意します。',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
