import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import "package:kenryo_tankyu/core/constants/work/info_value.dart";
import "package:kenryo_tankyu/core/constants/work/category_value.dart";
import "package:kenryo_tankyu/core/constants/work/sub_category_value.dart";
import 'package:kenryo_tankyu/features/search/domain/models/search.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/search_provider.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/search_history_provider.dart';

class SearchHistoryList extends ConsumerWidget {
  const SearchHistoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsyncValue = ref.watch(searchHistoryProvider);
    return historyAsyncValue.when(
        data: (searches) {
          return searches == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('検索履歴はありません。'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () => ref.invalidate(searchHistoryProvider),
                        child: const Text('リロードする')),
                  ],
                )
              : Expanded(
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      final Search search = searches[index];
                      final String word = _connectWord(search);
                      return ListTile(
                          trailing: const Icon(Icons.navigate_next),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(word,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              Text(
                                  search.numberOfHits == 20
                                      ? '20件+'
                                      : ' ${search.numberOfHits}件',
                                  style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                          onTap: () {
                            ref
                                .read(searchProvider.notifier)
                                .setParameters(search);
                            context.pushReplacement('/resultList');
                          });
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        height: 1,
                      );
                    },
                    itemCount: searches.length,
                  ),
                );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object error, StackTrace stackTrace) {
          debugPrint('error: $error');
          return Center(child: Text(error.toString()));
        });
  }

  String _connectWord(Search search) {
    final List<String> searchList = [];
    //searchList.addAll(search.searchWord!);
    search.category != Category.none
        ? searchList.add(search.category.displayName)
        : null;
    search.subCategory != SubCategory.none
        ? searchList.add(search.subCategory.displayName)
        : null;
    search.enterYear.displayName != 0
        ? searchList.add(search.enterYear.displayName.toString())
        : null;
    search.eventName != EventName.undefined
        ? searchList.add(search.eventName.displayName)
        : null;
    search.course != Course.undefined
        ? searchList.add(search.course.displayName)
        : null;
    return searchList.join(', ');
  }
}
