import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:kenryo_tankyu/core/constants/work/info_value.dart";
import "package:kenryo_tankyu/core/constants/work/category_value.dart";
import "package:kenryo_tankyu/core/constants/work/sub_category_value.dart";
import 'package:kenryo_tankyu/features/search/domain/models/search.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/search_provider.dart';

class SearchChipList extends ConsumerWidget {
  final bool forHeader; //ヘッダー用かどうか。キーワード入力画面でも使用しているため、そこではfalse
  const SearchChipList(this.forHeader, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Consumer(builder: (context, ref, child) {
        final notifier = ref.read(searchProvider.notifier);
        final Search data = ref.watch(searchProvider);
        final displayCategory =
            data.category != Category.none ? data.category.displayName : '';
        final displaySubCategory = data.subCategory != SubCategory.none
            ? data.subCategory.displayName
            : '';
        final displayEventName = data.eventName != EventName.undefined
            ? data.eventName.displayName
            : '';
        final displayCourse =
            data.course != Course.undefined ? data.course.displayName : '';
        final displayEnterYear = data.enterYear != EnterYear.undefined
            ? data.enterYear.displayName
            : '';
        final List<String> items = data.searchWord;

        final List<List<String>> searchList = [
          ['category', displayCategory],
          ['subCategory', displaySubCategory],
          ['year', displayEnterYear.toString()],
          ['eventName', displayEventName],
          ['course', displayCourse],
        ];
        final bool isAllEmpty =
            searchList.every((e) => e[1] == '') && items.isEmpty;

        return isAllEmpty
            ? const SizedBox()
            : SizedBox(
                height: 28,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: Colors.pinkAccent),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ///まず最初に検索ワードの中身を表示。その後にsearchListの中身を表示。
                          Text(
                              items.length > index
                                  ? items[index]
                                  : searchList
                                      .where((e) => e[1] != '')
                                      .toList()[index - items.length][1],
                              style: const TextStyle(fontSize: 14)),
                          SizedBox(
                            width: 20,
                            child: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () {
                                  items.length > index
                                      ? notifier.deleteWord(index)
                                      : notifier.deleteParameter(searchList
                                          .where((e) => e[1] != '')
                                          .toList()[index - items.length][0]);
                                },
                                icon: const Icon(Icons.clear, size: 16)),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 8);
                  },
                  itemCount: items.length +
                      searchList.where((e) => e[1] != '').toList().length,
                ),
              );
      }),
    );
  }
}
