import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:kenryo_tankyu/core/constants/work/category_value.dart";
import "package:kenryo_tankyu/core/constants/work/sub_category_value.dart";
import 'package:kenryo_tankyu/features/search/presentation/providers/search_provider.dart';

class SubCategoryChip extends ConsumerWidget {
  const SubCategoryChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(searchProvider.notifier);

    ///定義系①:選択されたカテゴリから、そのカテゴリに紐づくサブカテゴリを取得している。
    ///既にカテゴリが選択してあるのはsidebar.dartで確認済み。
    final Category categoryName = ref.watch(searchProvider).category;
    final List<SubCategory> exactSubCategoryList = categoryName.subCategories;

    ///定義系②:選択されたサブカテゴリを取得している。
    final SubCategory selectedSubCategory = ref.watch(searchProvider).subCategory;

    return Wrap(
      spacing: 8.0,
      children: List<Widget>.generate(exactSubCategoryList.length, (int index) {
        return ChoiceChip(
            label: Text(exactSubCategoryList[index].displayName),
            selected:
            exactSubCategoryList.indexOf(selectedSubCategory) == index,
            onSelected: (_) =>
                notifier.selectedSubCategory(exactSubCategoryList[index]));
      }).toList(),
    );
  }
}
