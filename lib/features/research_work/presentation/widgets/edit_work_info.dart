import 'package:flutter/material.dart';
import "package:kenryo_tankyu/core/constants/work/info_value.dart";
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';

class EditWorkInfo extends StatefulWidget {
  final Searched searched;
  EditWorkInfo({super.key, required this.searched});

  @override
  State<EditWorkInfo> createState() => _EditWorkInfoState();
}

class _EditWorkInfoState extends State<EditWorkInfo> {
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  Course? _selectedCourse;
  EnterYear? _selectedYear;

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
              .map<DropdownMenuItem<Course>>((Course value) =>
                  DropdownMenuItem(
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
                      value: value,
                      child: Text(value.displayName.toString())))
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
          onPressed: () {
            // 入力値を取得して処理
            final author = _authorController.text;
            final title = _titleController.text;
            final course = _selectedCourse?.displayName;
            final year = _selectedYear?.displayName;

            print('名前: $author');
            print('タイトル: $title');
            print('学科: $course');
            print('入学年度: $year');
          },
          child: const Text('保存'),
        ),
      ],
    );
  }
}
