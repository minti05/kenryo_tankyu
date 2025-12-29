import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/core/constants/work/category_value.dart';
import 'package:kenryo_tankyu/core/constants/work/info_value.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/search_provider.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/algolia_provider.dart';
import 'package:kenryo_tankyu/features/search/presentation/widgets/drop_button.dart';
import 'package:kenryo_tankyu/features/search/presentation/widgets/sub_category_chip.dart';

class SideBar extends ConsumerWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.topRight,
      child: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 16.0, top: 8.0, bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.clear)),
                    const Expanded(child: Text('絞り込み')),
                    ElevatedButton(
                        onPressed: () => ref
                            .read(searchProvider.notifier)
                            .deleteAllParameters(),
                        child: const Text('条件をクリア')),
                  ],
                ),
                Consumer(builder: (context, ref, child) {
                  final data = ref.watch(searchProvider);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10.0),
                      SearchDropButton(
                          name: 'カテゴリ',
                          selectedText: data.category.displayName,
                          choices: Category.values
                              .map((e) => e.displayName)
                              .toList()),
                      const SizedBox(height: 15.0),
                      SearchDropButton(
                          name: '期間',
                          selectedText: data.enterYear.displayName.toString(),
                          choices: EnterYear.values
                              .map((e) => e.displayName.toString())
                              .toList()),
                      const SizedBox(height: 15.0),
                      SearchDropButton(
                          name: 'イベント名',
                          selectedText: data.eventName.displayName,
                          choices: EventName.values
                              .map((e) => e.displayName)
                              .toList()),
                      const SizedBox(height: 15.0),
                      SearchDropButton(
                          name: '学科指定',
                          selectedText: data.course.displayName,
                          choices:
                              Course.values.map((e) => e.displayName).toList()),
                      const SizedBox(height: 15.0),
                      const Text('サブカテゴリを選択'),
                      data.category != Category.none
                          ? const SubCategoryChip()
                          : const Text(
                              'カテゴリを選択してください',
                              style: TextStyle(fontSize: 20),
                            ),
                    ],
                  );
                }),
                const Spacer(),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        ref.invalidate(algoliaSearchProvider);
                      },
                      child: const Text('再検索する')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
