import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import "package:kenryo_tankyu/core/constants/work/info_value.dart";
import "package:kenryo_tankyu/core/constants/work/category_value.dart";
import "package:kenryo_tankyu/core/constants/work/sub_category_value.dart";
import 'package:kenryo_tankyu/features/search/domain/models/search.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/search_history_provider.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/search_provider.dart';

class _AutoScrollText extends StatefulWidget {
  final String text;
  const _AutoScrollText(this.text);

  @override
  State<_AutoScrollText> createState() => _AutoScrollTextState();
}

class _AutoScrollTextState extends State<_AutoScrollText> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startScroll());
  }

  Future<void> _startScroll() async {
    if (!mounted || !_controller.hasClients) return;
    final maxScroll = _controller.position.maxScrollExtent;
    if (maxScroll <= 0) return;
    while (mounted) {
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted || !_controller.hasClients) return;
      await _controller.animateTo(
        maxScroll,
        duration: Duration(milliseconds: (maxScroll * 25).toInt()),
        curve: Curves.linear,
      );
      if (!mounted || !_controller.hasClients) return;
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted || !_controller.hasClients) return;
      _controller.jumpTo(0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _controller,
      physics: const NeverScrollableScrollPhysics(),
      child: Text(widget.text),
    );
  }
}

class SearchHistoryList extends ConsumerWidget {
  const SearchHistoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsyncValue = ref.watch(searchHistoryCacheProvider);
    return historyAsyncValue.when(
        data: (searches) {
          return searches == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('検索履歴はありません。'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () => ref
                            .read(searchHistoryCacheProvider.notifier)
                            .reload(),
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
                                child: _AutoScrollText(word),
                              ),
                              Text(' ${search.numberOfHits}件',
                                  style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                          onTap: () {
                            ref
                                .read(searchProvider.notifier)
                                .setParameters(search);
                            context.push('/resultList');
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
    searchList.addAll(search.searchWord);
    search.category != Category.none
        ? searchList.add(search.category.displayName)
        : null;
    search.subCategory != SubCategory.none
        ? searchList.add(search.subCategory.displayName)
        : null;
    search.enterYear != EnterYear.undefined
        ? searchList.add(search.enterYear.label)
        : null;
    search.course != Course.undefined
        ? searchList.add(search.course.displayName)
        : null;
    return searchList.join(', ');
  }
}
