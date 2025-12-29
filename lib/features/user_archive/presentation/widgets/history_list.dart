import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/features/search/presentation/widgets/result_preview_content.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/providers/user_archive_providers.dart';

class LibraryList extends ConsumerWidget {
  final bool onlyFavorite;
  const LibraryList({required this.onlyFavorite, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String str = onlyFavorite ? 'お気に入りに登録された作品は' : '履歴は';
    final historyAsyncValue = ref.watch(searchedHistoryProvider(onlyFavorite));
    return historyAsyncValue.when(
        data: (searcheds) {
          return searcheds == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('$strありません。'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () => ref
                            .invalidate(searchedHistoryProvider(onlyFavorite)),
                        child: const Text('リロードする')),
                  ],
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(searchedHistoryProvider(onlyFavorite));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: searcheds.length,
                      itemBuilder: (context, index) {
                        return Consumer(builder: (context, ref, child) {
                          final searched = searcheds[index];
                          return ResultPreviewContent(
                            searched: searched,
                            forLibrary: true,
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
          return Center(child: Text(error.toString()));
        });
  }
}
