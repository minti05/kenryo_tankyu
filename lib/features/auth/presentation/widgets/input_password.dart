import 'package:kenryo_tankyu/features/auth/domain/models/auth_failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kenryo_tankyu/features/auth/presentation/providers/auth_provider.dart';

class InputPassword extends ConsumerStatefulWidget {
  const InputPassword({super.key});

  @override
  ConsumerState<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends ConsumerState<InputPassword> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _confirmPasswordError;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLengthValid = false;
  bool _isAlphanumeric = false;
  bool _hasBothLettersAndNumbers = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('パスワードの条件', style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            children: [
              Icon(Icons.check,
                  color: _isLengthValid ? Colors.green : Colors.grey),
              const SizedBox(width: 10),
              Text('8文字以上',
                  style: TextStyle(
                      color: _isLengthValid ? Colors.green : Colors.grey)),
            ],
          ),
          Row(
            children: [
              Icon(Icons.check,
                  color: _isAlphanumeric ? Colors.green : Colors.grey),
              const SizedBox(width: 10),
              Text('半角英数字(a-z,A-Z,0-9)のみ',
                  style: TextStyle(
                      color: _isAlphanumeric ? Colors.green : Colors.grey)),
            ],
          ),
          Row(
            children: [
              Icon(Icons.check,
                  color:
                      _hasBothLettersAndNumbers ? Colors.green : Colors.grey),
              const SizedBox(width: 10),
              Text('英字と数字の組み合わせ',
                  style: TextStyle(
                      color: _hasBothLettersAndNumbers
                          ? Colors.green
                          : Colors.grey)),
            ],
          ),
          const SizedBox(height: 20),
          TextFormField(
            autofillHints: const [AutofillHints.password],
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: _obscurePassword
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              labelText: '新規パスワード',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onChanged: _validatePassword,
          ),
          const SizedBox(height: 20),
          TextFormField(
            enabled:
                _isLengthValid && _isAlphanumeric && _hasBothLettersAndNumbers,
            controller: _confirmPasswordController,
            obscureText: _obscureConfirmPassword,
            decoration: InputDecoration(
              errorText: _confirmPasswordError,
              suffixIcon: IconButton(
                icon: _obscureConfirmPassword
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
              labelText: '新規パスワード（確認）',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onChanged: _validateConfirmPassword,
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: _confirmPasswordController.text.length >= 8 &&
                      _confirmPasswordController.text ==
                          _passwordController.text
                  ? () async {
                      await _createAccountWithEmailAndPassword(
                          context, ref, _confirmPasswordController.text);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text('新規作成'),
            ),
          ),
        ],
      ),
    );
  }

  void _validatePassword(String value) {
    setState(() {
      _isLengthValid = value.length >= 8;
      _isAlphanumeric = RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value);
      _hasBothLettersAndNumbers =
          RegExp(r'(?=.*?[a-z])(?=.*?\d)').hasMatch(value);
    });
  }

  void _validateConfirmPassword(String value) {
    if (value != _passwordController.text) {
      setState(() {
        _confirmPasswordError = 'パスワードが一致しません';
      });
    } else {
      setState(() {
        _confirmPasswordError = null;
      });
    }
  }

  Future<void> _createAccountWithEmailAndPassword(
      BuildContext context, WidgetRef ref, String password) async {
    ref.read(authProvider.notifier).changePassword(password);
    try {
      await ref.read(authProvider.notifier).createUser(password);
      if (!context.mounted) return;
    } on AuthFailure catch (e) {
      if (e is EmailAlreadyInUse) {
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('エラーが発生しました。$e。'),
          ),
        );
      }
    }
  }
}
