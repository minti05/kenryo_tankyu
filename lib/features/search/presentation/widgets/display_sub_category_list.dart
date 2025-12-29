import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import "package:kenryo_tankyu/core/constants/work/category_value.dart";
import "package:kenryo_tankyu/core/constants/work/sub_category_value.dart";
import 'package:kenryo_tankyu/features/search/presentation/providers/search_provider.dart';

class DisplaySubCategoryList extends ConsumerWidget {
  const DisplaySubCategoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Category selectedCategory = ref.watch(searchProvider).category;
    final List<SubCategory> subCategoryList = selectedCategory.subCategories;
    final notifier = ref.read(searchProvider.notifier);
    return Column(
      children: [
        ListTile(
          title: const Text('すべて'),
          trailing: const Icon(Icons.navigate_next),
          onTap: () => context.pushReplacement('/resultList'),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child: Divider(
            height: 1,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: ListView.separated(
           itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){},
                child: ListTile(
                  trailing: const Icon(Icons.navigate_next),
                  title: Text(subCategoryList[index].displayName),
                  onTap: () {
                    notifier.selectedSubCategory(subCategoryList[index]);
                    context.pushReplacement('/resultList');
                    },
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: Divider(
                  height: 1,
                  color: Colors.grey,
                ),
              );
            },
            itemCount: subCategoryList.length,
          ),
        ),
      ],
    );
  }
}
