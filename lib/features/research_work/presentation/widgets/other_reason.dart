import 'package:flutter/material.dart';

class OtherReason extends StatefulWidget {
  const OtherReason({super.key});

  @override
  State<OtherReason> createState() => _OtherReasonState();
}

class _OtherReasonState extends State<OtherReason> {
  TextEditingController _freeDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _freeDescriptionController,
          maxLines: 5,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'テキスト',
          ),
        ),
        ElevatedButton(
            onPressed: () {
              print(_freeDescriptionController.text);
            },
            child: const Text('送信'))
      ],
    );
  }
}
