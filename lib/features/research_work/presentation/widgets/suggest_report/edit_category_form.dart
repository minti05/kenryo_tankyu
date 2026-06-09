import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:kenryo_tankyu/core/constants/work/category_value.dart";
import "package:kenryo_tankyu/core/constants/work/sub_category_value.dart";
import 'package:kenryo_tankyu/core/utils/write_spread_sheet.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';

enum _RadioValue { category1, category2 }

class EditCategoryForm extends ConsumerStatefulWidget {
  final Searched searched;
  const EditCategoryForm({super.key, required this.searched});

  @override
  ConsumerState<EditCategoryForm> createState() => _EditCategoryFormState();
}

class _EditCategoryFormState extends ConsumerState<EditCategoryForm> {
  _RadioValue _selectedRadio = _RadioValue.category1;
  Category _selectedCategory = Category.none;
  SubCategory _selectedSubCategory = SubCategory.other;
  bool _isSubmitting = false;

  Future<void> _submit() async {
    final searched = widget.searched;
    final radioLabel = _selectedRadio == _RadioValue.category1
        ? '${searched.category1.displayName} - ${searched.subCategory1.displayName}'
        : '${searched.category2.displayName} - ${searched.subCategory2.displayName}';

    setState(() => _isSubmitting = true);
    try {
      await EditSpreadSheet.instance.submitSuggestCategory(
        ref,
        searched.documentID,
        radioLabel,
        _selectedCategory.displayName,
        _selectedSubCategory.displayName,
      );
      if (mounted) {
        final messenger = ScaffoldMessenger.of(context);
        Navigator.of(context).pop();
        messenger.showSnackBar(
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
    final searched = widget.searched;
    return Column(
      children: [
        const Text(
          'どちらのカテゴリを修正しますか',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        RadioGroup<_RadioValue>(
          groupValue: _selectedRadio,
          onChanged: (value) {
            if (value != null) setState(() => _selectedRadio = value);
          },
          child: Column(
            children: [
              RadioListTile(
                title: Text(
                    '${searched.category1.displayName} - ${searched.subCategory1.displayName}'),
                value: _RadioValue.category1,
              ),
              RadioListTile(
                title: Text(
                    '${searched.category2.displayName} - ${searched.subCategory2.displayName}'),
                value: _RadioValue.category2,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<Category>(
          isExpanded: true,
          initialValue: _selectedCategory,
          onChanged: (value) {
            if (value == null) return;
            setState(() {
              _selectedCategory = value;
              _selectedSubCategory = SubCategory.other;
            });
          },
          items: Category.values
              .map(
                  (c) => DropdownMenuItem(value: c, child: Text(c.displayName)))
              .toList(),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'カテゴリ',
          ),
        ),
        if (_selectedCategory != Category.none) ...[
          const SizedBox(height: 8),
          DropdownButtonFormField<SubCategory>(
            isExpanded: true,
            decoration: const InputDecoration(
              hintText: 'サブカテゴリ',
              border: OutlineInputBorder(),
              isDense: true,
            ),
            initialValue: _selectedSubCategory,
            onChanged: (value) {
              if (value != null) setState(() => _selectedSubCategory = value);
            },
            items: _selectedCategory.subCategories
                .map((e) =>
                    DropdownMenuItem(value: e, child: Text(e.displayName)))
                .toList(),
          ),
        ],
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
