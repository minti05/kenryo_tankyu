import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/core/utils/write_spread_sheet.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';

class OtherReasonForm extends ConsumerStatefulWidget {
  final Searched searched;
  const OtherReasonForm({super.key, required this.searched});

  @override
  ConsumerState<OtherReasonForm> createState() => _OtherReasonFormState();
}

class _OtherReasonFormState extends ConsumerState<OtherReasonForm> {
  final TextEditingController _freeDescriptionController =
      TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _freeDescriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _isSubmitting = true);
    try {
      await EditSpreadSheet.instance.submitOtherReason(
        ref,
        widget.searched.documentID,
        _freeDescriptionController.text,
      );
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('送信しました。ご報告ありがとうございます。')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('送信に失敗しました。時間をおいて再試行してください。')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

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
          onPressed: _isSubmitting ? null : _submit,
          child: _isSubmitting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('送信'),
        ),
      ],
    );
  }
}
