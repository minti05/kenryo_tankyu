import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:kenryo_tankyu/core/constants/work/search_value.dart";
import 'package:kenryo_tankyu/presentation/widget/error_view.dart';

import 'package:kenryo_tankyu/features/search/presentation/widgets/result_list_preview.dart'; // ResultList is here
import 'package:kenryo_tankyu/features/search/presentation/widgets/result_header.dart';
import 'package:kenryo_tankyu/features/search/presentation/widgets/sidebar.dart';

import 'package:kenryo_tankyu/features/search/presentation/providers/algolia_provider.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/search_provider.dart';
import 'package:kenryo_tankyu/core/connectivity/connectivity_provider.dart';

class ResultListPage extends ConsumerWidget {
  const ResultListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: ResultHeader(onOpenFilters: () => _openFilters(context, ref)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final isConnected = ref.watch(isConnectedProvider);
                  final asyncValue = ref.watch(algoliaSearchProvider);
                  final sortedList = ref.watch(sortedListProvider);

                  return asyncValue.when(
                    data: (data) {
                      if (data == null) {
                        // algoliaSearchProvider が null を返すのは search.isEmpty の場合のみ
                        return const Center(child: Text('検索条件を設定してください'));
                      } else {
                        final currentPage = ref.watch(searchPageProvider);
                        final hits = data.hits;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _SearchResultToolbar(
                              resultCount: data.nbHits,
                              rangeStart:
                                  hits.isEmpty ? null : currentPage * 20 + 1,
                              rangeEnd: hits.isEmpty
                                  ? null
                                  : currentPage * 20 + hits.length,
                              onSort: (sortType) => ref
                                  .read(sortedListProvider.notifier)
                                  .sortList(sortType),
                              onOpenFilters: () => _openFilters(context, ref),
                            ),
                            if (hits.isEmpty)
                              const Expanded(
                                child: Center(
                                  child: Text(
                                    'ヒットしませんでした。\nキーワードやカテゴリを変えて再検索してください。',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            if (hits.isNotEmpty) ResultList(data: sortedList),
                            if (hits.isNotEmpty)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton.icon(
                                      onPressed: asyncValue.isLoading ||
                                              currentPage == 0
                                          ? null
                                          : () {
                                              ref
                                                  .read(searchPageProvider
                                                      .notifier)
                                                  .setPage(currentPage - 1);
                                            },
                                      icon: const Icon(Icons.arrow_back_ios,
                                          size: 16),
                                      label: const Text('前のページへ'),
                                    ),
                                    Text('${currentPage + 1}ページ目'),
                                    TextButton.icon(
                                      onPressed: asyncValue.isLoading ||
                                              data.isLastPage
                                          ? null
                                          : () {
                                              ref
                                                  .read(searchPageProvider
                                                      .notifier)
                                                  .setPage(currentPage + 1);
                                            },
                                      icon: const Icon(Icons.arrow_forward_ios,
                                          size: 16),
                                      label: const Text('次のページへ'),
                                      iconAlignment: IconAlignment.end,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        );
                      }
                    },
                    loading: () => Center(
                      child: isConnected
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 16),
                                Text('検索中...'),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.wifi_off_rounded,
                                  size: 52,
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                const SizedBox(height: 16),
                                const Text('インターネットに接続されていません。'),
                                const SizedBox(height: 8),
                                Text(
                                  '接続を待機しています...',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                      ),
                                ),
                              ],
                            ),
                    ),
                    error: (error, stackTrace) => CommonErrorView(
                      error: error,
                      onRetry: () => ref.invalidate(algoliaSearchProvider),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openFilters(BuildContext context, WidgetRef ref) async {
    final selected = await showSearchFilterSheet(
      context,
      ref.read(searchProvider),
    );
    if (selected == null) return;
    ref.read(searchProvider.notifier).setParameters(selected);
    ref.invalidate(algoliaSearchProvider);
  }
}

class _SearchResultToolbar extends StatelessWidget {
  const _SearchResultToolbar({
    required this.resultCount,
    required this.rangeStart,
    required this.rangeEnd,
    required this.onSort,
    required this.onOpenFilters,
  });

  final int resultCount;
  final int? rangeStart;
  final int? rangeEnd;
  final ValueChanged<SortType> onSort;
  final VoidCallback onOpenFilters;

  @override
  Widget build(BuildContext context) {
    final actionStyle = TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      minimumSize: const Size(0, 36),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              rangeStart == null
                  ? '0件（全$resultCount件）'
                  : '$rangeStart〜$rangeEnd件（全$resultCount件）',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          PopupMenuButton<SortType>(
            tooltip: '並び替え',
            padding: EdgeInsets.zero,
            onSelected: onSort,
            itemBuilder: (context) => SortType.values
                .map(
                  (sortType) => PopupMenuItem(
                    value: sortType,
                    child: Text(sortType.displayName),
                  ),
                )
                .toList(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.swap_vert_rounded,
                    size: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 4),
                  const Text('並び替え', style: TextStyle(fontSize: 13)),
                ],
              ),
            ),
          ),
          _ToolbarAction(
            icon: Icons.tune_rounded,
            label: 'フィルター',
            style: actionStyle,
            onPressed: onOpenFilters,
          ),
        ],
      ),
    );
  }
}

class _ToolbarAction extends StatelessWidget {
  const _ToolbarAction({
    required this.icon,
    required this.label,
    required this.style,
    this.onPressed,
  });

  final IconData icon;
  final String label;
  final ButtonStyle style;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label, style: const TextStyle(fontSize: 13)),
      style: style,
    );
  }
}
