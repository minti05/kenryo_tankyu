import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:kenryo_tankyu/core/constants/work/search_value.dart";

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
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, top: 4.0, bottom: 4.0),
                              child: Text(
                                data.length == 20
                                    ? '20件以上ヒットしました'
                                    : '${data.length.toString()}件ヒットしました',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            ResultList(data: sortedList),
                          ],
                        );
                      }
                    },
                    loading: () => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(height: 16),
                          if (!isConnected) ...[
                            const Text('インターネットに接続されていません'),
                            const Text('再接続を待機しています...',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ] else
                            const Text('検索中...'),
                        ],
                      ),
                    ),
                    error: (error, stackTrace) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.cloud_off,
                                size: 64, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            const Text('検索中にエラーが発生しました'),
                            Text(error.toString(),
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: () =>
                                  ref.invalidate(algoliaSearchProvider),
                              icon: const Icon(Icons.refresh),
                              label: const Text('再試行'),
                            ),
                          ],
                        ),
                      );
                    },
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
