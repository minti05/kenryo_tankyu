import 'package:kenryo_tankyu/presentation/widget/error_dialog.dart';
import 'package:kenryo_tankyu/core/error/failures.dart';
import 'package:kenryo_tankyu/core/providers/firebase_providers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/features/auth/presentation/providers/auth_provider.dart';

class InputPasswordForLogin extends ConsumerStatefulWidget {
  final String password;
  const InputPasswordForLogin(this.password, {super.key});

  @override
  ConsumerState<InputPasswordForLogin> createState() =>
      _InputPasswordForLoginState();
}

class _InputPasswordForLoginState extends ConsumerState<InputPasswordForLogin> {
  late TextEditingController _controller;
  bool _obscureText = true;
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.password);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _controller,
          obscureText: _obscureText,
          decoration: InputDecoration(
            errorText: _passwordError,
            suffixIcon: IconButton(
              icon: _obscureText
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            labelText: 'パスワード',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onChanged: _validatePassword,
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: _passwordError == null &&
                    ref.watch(authProvider).email != null &&
                    _controller.text != ''
                ? () async {
                    await _login(
                        context, ref, _controller.text);
                  }
                : null,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child: const Text('認証'),
          ),
        ),
      ],
    );
  }

  Future<void> _login(BuildContext context, WidgetRef ref, String password) async {
    final rawEmail = ref.read(authProvider).email;
    if (rawEmail == null) return;

    try {
      await ref
          .read(authProvider.notifier)
          .login(rawEmail, password);

      // ログイン成功時にFCMトークンを取得 (Log only based on original?)
      // Original code did get token.
      try {
        final messaging = ref.read(firebaseMessagingProvider);
        String? fcmToken = await messaging.getToken();
        debugPrint('FCMトークン: $fcmToken');
      } catch (e) {
        debugPrint('FCM Token Error: $e');
      }
    } on Failure catch (e) {
      if (!mounted) return;

      showErrorDialog(context, e);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('予期せぬエラーが発生しました: $e'),
        ),
      );
    }
  }

  void _validatePassword(String value) {
    if (value.length < 8) {
      setState(() {
        _passwordError = 'パスワードは8桁以上です';
      });
    } else {
      setState(() {
        _passwordError = null;
      });
    }
  }
}
