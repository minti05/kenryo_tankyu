import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:kenryo_tankyu/core/constants/work/category_value.dart";
import 'package:kenryo_tankyu/features/search/presentation/providers/search_provider.dart';
import 'package:kenryo_tankyu/features/search/presentation/widgets/display_sub_category_list.dart';
import 'package:kenryo_tankyu/features/search/presentation/widgets/sub_category_select_header.dart';

class SubCategorySelectPage extends ConsumerWidget {
  const SubCategorySelectPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Category selectedCategory = ref.watch(searchProvider).category;
    return Scaffold(
      appBar: SubCategorySelectHeader(categoryWord:selectedCategory.displayName),
      body: const DisplaySubCategoryList(),
    );
  }
}
