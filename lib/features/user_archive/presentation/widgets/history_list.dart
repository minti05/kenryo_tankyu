import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/core/utils/device_type.dart';
import 'package:kenryo_tankyu/features/search/presentation/widgets/result_preview_content.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/providers/user_archive_providers.dart';
import 'package:kenryo_tankyu/presentation/widget/error_view.dart';

class LibraryList extends ConsumerStatefulWidget {
  final bool onlyFavorite;
  const LibraryList({required this.onlyFavorite, super.key});

  @override
  ConsumerState<LibraryList> createState() => _LibraryListState();
}

class _LibraryListState extends ConsumerState<LibraryList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref
          .read(searchedHistoryProvider(widget.onlyFavorite).notifier)
          .fetchMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final String str = widget.onlyFavorite ? 'お気に入りに登録された作品は' : '履歴は';
    final historyAsyncValue =
        ref.watch(searchedHistoryProvider(widget.onlyFavorite));
    return historyAsyncValue.when(
      data: (searcheds) {
        if (searcheds.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$strありません。'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => ref
                    .invalidate(searchedHistoryProvider(widget.onlyFavorite)),
                child: const Text('リロードする'),
              ),
            ],
          );
        }

        final notifier =
            ref.read(searchedHistoryProvider(widget.onlyFavorite).notifier);
        final hasMore = notifier.hasMore;

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(searchedHistoryProvider(widget.onlyFavorite));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: context.isTablet
                ? GridView.builder(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 4,
                      mainAxisExtent: 130,
                    ),
                    itemCount: searcheds.length + (hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == searcheds.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final searched = searcheds[index];
                      return Card(
                        child: ResultPreviewContent(
                          searched: searched,
                          mode: ResultPreviewMode.library,
                        ),
                      );
                    },
                  )
                : ListView.separated(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: searcheds.length + (hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == searcheds.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      return Consumer(builder: (context, ref, child) {
                        final searched = searcheds[index];
                        return ResultPreviewContent(
                          searched: searched,
                          mode: ResultPreviewMode.library,
                        );
                      });
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(),
                      );
                    },
                  ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (Object error, StackTrace stackTrace) {
        return CommonErrorView(
          error: error,
          onRetry: () =>
              ref.invalidate(searchedHistoryProvider(widget.onlyFavorite)),
        );
      },
    );
  }
}
