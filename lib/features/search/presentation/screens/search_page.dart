import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kenryo_tankyu/core/constants/work/info_value.dart';
import 'package:kenryo_tankyu/core/constants/work/sub_category_value.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/search_history_repository_provider.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/search_history_provider.dart';
import 'package:kenryo_tankyu/core/constants/work/category_value.dart';
import 'package:kenryo_tankyu/features/search/domain/models/search.dart';

import 'package:kenryo_tankyu/features/search/presentation/widgets/search_header.dart';
import 'package:kenryo_tankyu/features/search/presentation/widgets/search_chip_list.dart';
import 'package:kenryo_tankyu/features/search/presentation/widgets/search_history_list.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/search_provider.dart';
import 'package:kenryo_tankyu/presentation/widget/widget.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const SearchHeader(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Consumer(builder: (context, ref, child) {
              return _SelectedChipList(ref, context);
            }),
            Consumer(
              builder: (context, ref, child) {
                final suggestCategory = ref.watch(suggestCategoryProvider);
                final suggestSubCategory =
                    ref.watch(suggestSubCategoryProvider);
                final whatCategory = Category.values.firstWhere(
                  (cat) => cat.subCategories.contains(suggestSubCategory),
                  orElse: () =>
                      Category.none, //サブカテゴリーを提案された時、それがどのカテゴリーに属すかを取得
                );
                if (suggestCategory != Category.none ||
                    suggestSubCategory != SubCategory.none) {
                  return ListTile(
                    leading: Chip(
                      label: const Text('提案'),
                      labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface),
                      backgroundColor:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    title: suggestCategory != Category.none
                        ? Text('${suggestCategory.displayName}')
                        : Text(
                            '${whatCategory.displayName} > ${suggestSubCategory.displayName}'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () => _onTapCategory(context, suggestCategory,
                        suggestSubCategory, whatCategory, ref),
                  );
                } else {
                  return ListTile(
                    title: const Text('またはカテゴリから選ぶ'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      ref.read(footerProvider.notifier).state = 1;
                      context.go('/explore');
                    },
                  );
                }
              },
            ),
            const Divider(
              height: 1,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              child: Row(
                children: [
                  const Icon(Icons.history),
                  const SizedBox(width: 8),
                  const Text('検索履歴', style: TextStyle(fontSize: 20)),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('検索履歴を削除しますか？'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('キャンセル'),
                              ),
                              TextButton(
                                onPressed: () {
                                  ref
                                      .read(searchHistoryRepositoryProvider)
                                      .deleteAllHistory();
                                  ref.invalidate(searchHistoryProvider);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('削除'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            const SearchHistoryList(),
          ],
        ),
      ),
    );
  }

  _onTapCategory(BuildContext context, Category suggestCategory,
      SubCategory suggestSubCategory, Category whatCategory, WidgetRef ref) {
    final notifier = ref.read(searchProvider.notifier);
    if (suggestCategory != Category.none) {
      notifier.selectedCategory(suggestCategory);
      context.pushReplacement('/subCategory');
    } else {
      notifier.selectedCategory(whatCategory);
      notifier.selectedSubCategory(suggestSubCategory);
      context.pushReplacement('/resultList');
    }
  }

  Widget _SelectedChipList(WidgetRef ref, BuildContext context) {
    final Search data = ref.watch(searchProvider);
    final bool isAllEmpty = data.searchWord.isEmpty &&
        data.category == Category.none &&
        data.subCategory == SubCategory.none &&
        data.enterYear == EnterYear.undefined &&
        data.eventName == EventName.undefined &&
        data.course == Course.undefined;
    if (isAllEmpty) {
      return const SizedBox();
    } else {
      return Column(
        children: [
          SizedBox(height: 8),
          ListTile(
            tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            horizontalTitleGap: 7,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('現在の検索条件',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                SearchChipList(false),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.search_sharp),
              onPressed: () {
                context.pushReplacement('/resultList');
              },
            ),
          ),
        ],
      );
    }
  }
}
