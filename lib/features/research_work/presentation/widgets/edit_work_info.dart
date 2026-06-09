import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:kenryo_tankyu/core/constants/work/info_value.dart";
import 'package:kenryo_tankyu/core/utils/write_spread_sheet.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';

class EditWorkInfo extends ConsumerStatefulWidget {
  final Searched searched;
  const EditWorkInfo({super.key, required this.searched});

  @override
  ConsumerState<EditWorkInfo> createState() => _EditWorkInfoState();
}

class _EditWorkInfoState extends ConsumerState<EditWorkInfo> {
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  Course? _selectedCourse;
  EnterYear? _selectedYear;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _authorController.text = widget.searched.author;
    _titleController.text = widget.searched.title;
    _selectedCourse = widget.searched.course;
    _selectedYear = widget.searched.enterYear;
  }

  @override
  void dispose() {
    _authorController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _isSubmitting = true);
    try {
      await EditSpreadSheet.instance.submitSuggestWorksInfo(
        ref,
        widget.searched.documentID,
        _authorController.text,
        _titleController.text,
        _selectedCourse?.displayName ?? '',
        _selectedYear?.displayName.toString() ?? '',
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('間違っている箇所の訂正をお願いします',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        TextFormField(
          controller: _authorController,
          decoration: const InputDecoration(
            isDense: true,
            labelText: '名前',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          minLines: 2,
          maxLines: 3,
          controller: _titleController,
          decoration: const InputDecoration(
            isDense: true,
            labelText: 'タイトル',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField(
          decoration: const InputDecoration(
            labelText: '学科',
            border: OutlineInputBorder(),
            isDense: true,
          ),
          initialValue: _selectedCourse,
          items: Course.values
              .map<DropdownMenuItem<Course>>((Course value) => DropdownMenuItem(
                  value: value, child: Text(value.displayName)))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedCourse = value;
            });
          },
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField(
          decoration: const InputDecoration(
            labelText: '入学年度',
            border: OutlineInputBorder(),
            isDense: true,
          ),
          initialValue: _selectedYear,
          items: EnterYear.values
              .map<DropdownMenuItem<EnterYear>>((EnterYear value) =>
                  DropdownMenuItem(
                      value: value, child: Text(value.displayName.toString())))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedYear = value;
            });
          },
          hint: const Text('入学年度を選択してください'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _submit,
          child: _isSubmitting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('保存'),
        ),
      ],
    );
  }
}
