import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import "package:kenryo_tankyu/core/constants/work/category_value.dart";
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/presentation/widget/award_chip.dart';
import 'package:kenryo_tankyu/features/search/presentation/widgets/image_chip.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/providers/user_archive_providers.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/widgets/favorite_button.dart';

enum ResultPreviewMode { search, library }

class ResultPreviewContent extends ConsumerWidget {
  final Searched searched;
  final ResultPreviewMode mode;
  final bool showAwardChip;
  const ResultPreviewContent(
      {super.key,
      required this.searched,
      required this.mode,
      this.showAwardChip = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        context.push('/result/${searched.documentID}');
      },
      onLongPress: mode == ResultPreviewMode.library
          ? () async {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('履歴を消去しますか？'),
                    content: Text(
                      searched.isFavorite
                          ? '「${searched.title}」の履歴を消去しますか？\n\nこの作品はお気に入りに登録されています。消去すると、お気に入り状態も同時に解除されます。'
                          : '「${searched.title}」の履歴を消去しますか？',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('キャンセル'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await ref
                              .read(historyControllerProvider.notifier)
                              .deleteHistory(
                                searched.documentID,
                                isFavorite: searched.isFavorite,
                              );
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
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
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 6,
                        children: [
                          Text(
                              '${searched.enterYear.displayName.toString()}年度入学 ${searched.course.displayName}'),
                          if (showAwardChip &&
                              searched.awardDisplayText != null)
                            AwardChip(text: searched.awardDisplayText!),
                        ],
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                  child: FavoriteButton(
                    searched: searched,
                    isLarge: false,
                    enabled: mode == ResultPreviewMode.library,
                  ),
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
