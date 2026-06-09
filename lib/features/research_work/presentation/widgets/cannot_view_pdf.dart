import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:kenryo_tankyu/core/constants/work/info_value.dart";
import 'package:kenryo_tankyu/core/utils/write_spread_sheet.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';

class CannotViewPdf extends ConsumerStatefulWidget {
  final Searched searched;
  const CannotViewPdf({super.key, required this.searched});

  @override
  ConsumerState<CannotViewPdf> createState() => _CannotViewPdfState();
}

class _CannotViewPdfState extends ConsumerState<CannotViewPdf> {
  late List<bool> _selectedCannotViewPdf;
  final TextEditingController _freeDescriptionController =
      TextEditingController();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _selectedCannotViewPdf =
        List.generate(DocumentType.values.length, (index) => false);
  }

  @override
  void dispose() {
    _freeDescriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final selectedTypes = [
      for (int i = 0; i < DocumentType.values.length; i++)
        if (_selectedCannotViewPdf[i]) DocumentType.values[i].displayName
    ];

    setState(() => _isSubmitting = true);
    try {
      await EditSpreadSheet.instance.submitCannotViewPdf(
        ref,
        widget.searched.documentID,
        selectedTypes,
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
        const Text('問題のあるPDFを選択してください',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: DocumentType.values.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(DocumentType.values[index].displayName),
                value: _selectedCannotViewPdf[index],
                onChanged: (bool? value) {
                  setState(() {
                    _selectedCannotViewPdf[index] = value!;
                  });
                },
              );
            }),
        TextFormField(
          controller: _freeDescriptionController,
          maxLines: 3,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '自由記述',
          ),
        ),
        const SizedBox(height: 8),
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
