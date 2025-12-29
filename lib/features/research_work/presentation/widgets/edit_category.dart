import 'package:flutter/material.dart';
import "package:kenryo_tankyu/core/constants/work/category_value.dart";
import "package:kenryo_tankyu/core/constants/work/sub_category_value.dart";
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';

enum RadioValue { category1, category2 }

class EditCategory extends StatefulWidget {
  final Searched searched;
  const EditCategory({super.key, required this.searched});

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  RadioValue? selectedRadio = RadioValue.category1;
  Category selectedCategory = Category.none;
  SubCategory selectedSubCategory = SubCategory.other;

  @override
  Widget build(BuildContext context) {
    final searched = widget.searched;
    return Column(
      children: [
        const Text(
          'どちらのカテゴリを修正しますか',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        _buildRadioListTile(searched),
        const SizedBox(height: 8),
        _buildCategoryDropdown(),
        const SizedBox(height: 8),
        if (selectedCategory != Category.none) _buildSubCategoryDropdown(),
        const SizedBox(height: 8),
        _buildSubmitButton(),
      ],
    );
  }

  Widget _buildRadioListTile(Searched searched) {
    return RadioGroup(
      groupValue: selectedRadio,
      onChanged: (RadioValue? value) {
        setState(() => selectedRadio = value);
      },
      child: Column(
        children: [
          RadioListTile(
              title: Text(
                  '${searched.category1.displayName} - ${searched.subCategory1.displayName}'),
              value: RadioValue.category1),
          RadioListTile(
              title: Text(
                  '${searched.category2.displayName} - ${searched.subCategory2.displayName}'),
              value: RadioValue.category2),
        ],
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField(
      initialValue: selectedCategory,
      onChanged: (Category? value) {
        setState(() {
          selectedCategory = value!;
          selectedSubCategory = SubCategory.other;
        });
      },
      items: Category.values
          .map((category) => DropdownMenuItem(
                value: category,
                child: Text(category.displayName),
              ))
          .toList(),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'カテゴリ',
      ),
    );
  }

  Widget _buildSubCategoryDropdown() {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        hintText: 'サブカテゴリ',
        border: OutlineInputBorder(),
        isDense: true,
      ),
      initialValue: selectedSubCategory,
      onChanged: (SubCategory? value) {
        setState(() {
          selectedSubCategory = value!;
        });
      },
      items: selectedCategory.subCategories
          .map((e) => DropdownMenuItem(value: e, child: Text(e.displayName)))
          .toList(),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        print('category: $selectedCategory, subCategory: $selectedSubCategory');
      },
      child: const Text('送信'),
    );
  }
}
