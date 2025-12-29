import 'package:firebase_auth/firebase_auth.dart';
import 'package:kenryo_tankyu/core/providers/firebase_providers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kenryo_tankyu/features/auth/presentation/providers/auth_provider.dart';

class InputPasswordForLogin extends ConsumerStatefulWidget {
  final String password;
  final bool isDeveloper; 
  const InputPasswordForLogin(this.password, this.isDeveloper, {super.key});

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
                    await _login(context, ref, _controller.text, widget.isDeveloper);
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

  Future<void> _login(
      BuildContext context, WidgetRef ref, String password, bool isDeveloper) async {
    final rawEmail = ref.read(authProvider).email;
    if (rawEmail == null) return;
    
    try {
      await ref.read(authProvider.notifier).login(rawEmail, password, isDeveloper);
      
      // ログイン成功時にFCMトークンを取得 (Log only based on original?)
      // Original code did get token.
      try {
        final messaging = ref.read(firebaseMessagingProvider);
        String? fcmToken = await messaging.getToken();
        debugPrint('FCMトークン: $fcmToken');
      } catch (e) {
        debugPrint('FCM Token Error: $e');
      }

    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('メールアドレスが見つかりませんでした'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
        content: Column(
          children: [
            const Text('パスワードが間違っています'),
            ElevatedButton(
            onPressed: () =>
            context.go('/welcome/login/reset_password'),
            child: const Text('パスワードをリセットする')),
          ],
        ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('エラーが発生しました: ${e.message}'),
          ),
        );
      }
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
