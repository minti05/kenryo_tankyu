import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kenryo_tankyu/core/constants/app_unique_value.dart';
import 'package:kenryo_tankyu/core/error/failures.dart';
import 'package:kenryo_tankyu/features/auth/presentation/providers/auth_provider.dart';

class WelcomePage extends ConsumerWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
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
              const SizedBox(height: 12),
              Text(
                'このアプリは松本県ケ丘高等学校に在籍する生徒および職員が利用できる探究活動サポートアプリです。\n生徒のプライバシー保護のため、他の方はご利用いただけませんのでご了承ください。',
                style: Theme.of(context).textTheme.bodySmall!,
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 1),
              _GoogleSignInButton(
                onPressed: () => _signInWithGoogle(context, ref),
              ),
              const SizedBox(height: 16),
              _TermsText(context),
              const Spacer(flex: 2),
              _emailLoginSection(context, ref),
              const SizedBox(height: 20),
              Text('Version: $version',
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signInWithGoogle(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(authProvider.notifier).loginWithGoogle();
    } on Failure catch (e) {
      debugPrint('[GoogleSignIn] Failure: ${e.message}');
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(e.message), duration: const Duration(seconds: 5)),
      );
    } catch (e) {
      debugPrint('[GoogleSignIn] Unexpected error: $e');
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('サインインに失敗しました。\n$e')),
      );
    }
  }

  Widget _emailLoginSection(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('または',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Theme.of(context).colorScheme.outline)),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => _showDialog(false, context, ref),
              child: Text('新規登録（メール）',
                  style: Theme.of(context).textTheme.bodySmall),
            ),
            Text('／',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).colorScheme.outline)),
            TextButton(
              onPressed: () => _showDialog(true, context, ref),
              child: Text('ログイン（メール）',
                  style: Theme.of(context).textTheme.bodySmall),
            ),
          ],
        ),
      ],
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

class _GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _GoogleSignInButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: BorderSide(
            color: isDark ? Colors.white54 : Colors.black26,
          ),
          backgroundColor:
              isDark ? const Color(0xFF131314) : const Color(0xFFFFFFFF),
          foregroundColor: isDark ? Colors.white : const Color(0xFF1F1F1F),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/google_logo.svg',
                width: 24, height: 24),
            const SizedBox(width: 12),
            Text(
              '縣陵アカウントでサインイン',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : const Color(0xFF1F1F1F),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TermsText extends StatelessWidget {
  final BuildContext parentContext;

  const _TermsText(this.parentContext);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
        children: [
          const TextSpan(text: 'サインインすることで'),
          TextSpan(
            text: '利用規約',
            style: const TextStyle(
                color: Colors.blue, decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () => launchUrl(termsOfServiceLink),
          ),
          const TextSpan(text: 'および'),
          TextSpan(
            text: 'プライバシーポリシー',
            style: const TextStyle(
                color: Colors.blue, decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () => launchUrl(privacyPolicyLink),
          ),
          const TextSpan(text: 'に同意したものとみなします。'),
        ],
      ),
    );
  }
}
