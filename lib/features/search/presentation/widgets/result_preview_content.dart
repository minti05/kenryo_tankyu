import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kenryo_tankyu/core/constants/const.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/models.dart';
import 'package:kenryo_tankyu/features/search/presentation/widgets/image_chip.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/providers/providers.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/widgets/favorite.dart';

class ResultPreviewContent extends ConsumerWidget {
  final Searched searched;
  final bool forLibrary;
  const ResultPreviewContent(
      {super.key, required this.searched, required this.forLibrary});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        ///詳細画面への遷移と、履歴の追加
        context.push('/result/${searched.documentID}');
      },
      onLongPress: forLibrary
          ? () async {
              ///履歴の消去
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('履歴を消去しますか？'),
                    content: Text('「${searched.title}」の履歴を消去しますか？'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('キャンセル'),
                      ),
                      TextButton(
                        onPressed: () {
                          ref
                              .read(userArchiveRepositoryProvider)
                              .deleteHistory(searched.documentID);
                          ref.invalidate(searchedHistoryProvider);
                          Navigator.of(context).pop();
                        },
                        child: const Text('消去'),
                      ),
                    ],
                  );
                },
              );
            }
          : null,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                  child: SizedBox(
                      width: 50,
                      height: 50,
                      child: WorkImageChip(searched: searched)),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(searched.title,
                          style: const TextStyle(fontSize: 16),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Text(
                          '${searched.enterYear.displayName.toString()}年度入学 ${searched.course.displayName}'),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                  child: forLibrary
                      ? FavoriteForHistory(searched: searched)
                      : FavoriteForResultListPage(searched: searched),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Chip(
                      label: Text(
                        '${searched.category1.displayName} > ${searched.subCategory1.displayName}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      visualDensity: const VisualDensity(vertical: -4),
                      padding: EdgeInsets.zero),
                  const SizedBox(width: 8),
                  searched.category2 == Category.none
                      ? const SizedBox.shrink()
                      : Chip(
                          label: Text(
                              '${searched.category2.displayName} > ${searched.subCategory2.displayName}',
                              style: const TextStyle(fontSize: 14)),
                          visualDensity: const VisualDensity(vertical: -4),
                          padding: EdgeInsets.zero),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
