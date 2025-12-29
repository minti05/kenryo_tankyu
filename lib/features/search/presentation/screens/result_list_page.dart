import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:kenryo_tankyu/core/constants/work/search_value.dart";
import 'package:kenryo_tankyu/features/search/data/datasources/search_history_db.dart';

import 'package:kenryo_tankyu/features/search/presentation/widgets/result_list_preview.dart'; // ResultList is here
import 'package:kenryo_tankyu/features/search/presentation/widgets/result_header.dart';
import 'package:kenryo_tankyu/features/search/presentation/widgets/sidebar.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/search_provider.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/algolia_provider.dart';

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
                  final asyncValue = ref.watch(algoliaSearchProvider);
                  final sortedList = ref.watch(sortedListProvider);
                  final provider = ref.watch(searchProvider);
                  return asyncValue.when(
                    data: (data) {
                      if (data == null) {
                        return Center(
                            child: Column(
                          children: [
                            const Text('データがヒットしませんでした'),
                            const SizedBox(height: 20),
                            ElevatedButton(
                                onPressed: () =>
                                    ref.invalidate(algoliaSearchProvider),
                                child: const Text('リロードする')),
                          ],
                        )); //TODO ユーザーに検索条件を変えさせるようにする。変えないと再読み込みできないようにしたい。
                      } else {
                        ///検索履歴に保存
                        SearchHistoryController.instance.insertHistory(
                            provider.copyWith(
                                savedAt: DateTime.now(),
                                numberOfHits: data.length));
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
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stackTrace) {
                      return Center(
                        child: Column(
                          children: [
                            const Text('エラーが発生しました'),
                            Text(error.toString()),
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
