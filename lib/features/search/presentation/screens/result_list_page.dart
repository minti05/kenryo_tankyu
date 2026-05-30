import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:kenryo_tankyu/core/constants/work/search_value.dart";
import 'package:kenryo_tankyu/presentation/widget/error_view.dart';

import 'package:kenryo_tankyu/features/search/presentation/widgets/result_list_preview.dart'; // ResultList is here
import 'package:kenryo_tankyu/features/search/presentation/widgets/result_header.dart';
import 'package:kenryo_tankyu/features/search/presentation/widgets/sidebar.dart';

import 'package:kenryo_tankyu/features/search/presentation/providers/algolia_provider.dart';
import 'package:kenryo_tankyu/core/connectivity/connectivity_provider.dart';

class ResultListPage extends ConsumerWidget {
  ResultListPage({super.key});

  ///drawerを開くボタンをbody内で使うために、ScaffoldにGlobalKeyを指定して、Scaffoldの状態を保持しているScaffoldStateを参照できるようにします。
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///書き換えるときに使うところ
    return Scaffold(
      key: _scaffoldKey,
      appBar: const ResultHeader(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PopupMenuButton(
                  icon: const Icon(Icons.sort),
                  itemBuilder: (context) {
                    return SortType.values //sortTypeはvalue.dartに定義
                        .map((e) => PopupMenuItem(
                              onTap: () => ref
                                  .read(sortedListProvider.notifier)
                                  .sortList(e),
                              value: e,
                              child: Text(e.name),
                            ))
                        .toList();
                  },
                ),
                IconButton(
                    onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
                    icon: const Icon(Icons.tune)),
              ],
            ),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final isConnected = ref.watch(isConnectedProvider);
                  final asyncValue = ref.watch(algoliaSearchProvider);
                  final sortedList = ref.watch(sortedListProvider);

                  return asyncValue.when(
                    data: (data) {
                      if (data == null) {
                        return Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('データがヒットしませんでした'),
                            const SizedBox(height: 20),
                            ElevatedButton(
                                onPressed: () =>
                                    ref.invalidate(algoliaSearchProvider),
                                child: const Text('リロードする')),
                          ],
                        ));
                      } else {
                        final currentPage = ref.watch(searchPageProvider);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, top: 4.0, bottom: 4.0),
                              child: Text(
                                data.isEmpty
                                    ? '該当するデータはありません'
                                    : data.length == 20
                                        ? '${currentPage * 20 + 1}〜${currentPage * 20 + 20}件目を表示中'
                                        : currentPage == 0
                                            ? '${data.length}件ヒットしました'
                                            : '${currentPage * 20 + 1}〜${currentPage * 20 + data.length}件目を表示中',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            ResultList(data: sortedList),
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
                                                .read(
                                                    searchPageProvider.notifier)
                                                .setPage(currentPage - 1);
                                          },
                                    icon: const Icon(Icons.arrow_back_ios,
                                        size: 16),
                                    label: const Text('前のページへ'),
                                  ),
                                  Text('${currentPage + 1}ページ目'),
                                  TextButton.icon(
                                    onPressed: asyncValue.isLoading ||
                                            data.length < 20
                                        ? null
                                        : () {
                                            ref
                                                .read(
                                                    searchPageProvider.notifier)
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
      endDrawer: const SideBar(),
    );
  }
}
