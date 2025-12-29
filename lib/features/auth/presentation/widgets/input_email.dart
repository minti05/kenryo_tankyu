import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kenryo_tankyu/features/auth/presentation/providers/auth_provider.dart';

class InputEmail extends ConsumerStatefulWidget {
  final String email;
  final bool isEdit;
  final bool isDeveloper;
  const InputEmail(this.email, this.isEdit, this.isDeveloper, {super.key});

  @override
  ConsumerState<InputEmail> createState() => _InputEmailState();
}

class _InputEmailState extends ConsumerState<InputEmail> {

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(authProvider.notifier);

    return TextField(
      textInputAction: TextInputAction.done,
      enabled: widget.isEdit,
      keyboardType: TextInputType.emailAddress,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_.+-]')),  //メールアドレスの入力制限
      ],
      controller: _controller,
      decoration: InputDecoration(
        suffixText: widget.isDeveloper ? '@developer.com': '@kenryo.ed.jp',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onChanged: (text) => notifier.changeEmail(text),
    );
  }
}
