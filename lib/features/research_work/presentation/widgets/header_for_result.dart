import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/providers/searched_provider.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/widgets/overlay_dialog.dart';

class HeaderForResultPage extends ConsumerWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  const HeaderForResultPage({required this.searched, super.key});
  final Searched searched;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(searchedItemProvider(searched.documentID));
    final String cachedText = searched.isCached ? '(オフラインから取得)' : '(オンラインから取得)';
    debugPrint(cachedText);
    return AppBar(
      actions: [
        data.when(
          data: (searched) {
            return PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    onTap: () {
                      //forceReloadProviderをtrueにして、再取得させる
                      ref.read(forceReloadProvider.notifier).state = true;
                      ref.invalidate(searchedItemProvider(searched.documentID));
                    },
                    child: Text('リロードする$cachedText'),
                  ),
                  PopupMenuItem(
                    onTap: () =>
                        Navigator.of(context).push(OverlayDialog(searched)),
                    child: const Text('情報の変更を提案'),
                  ),
                  PopupMenuItem(
                    onTap: () async {
                      final data = ClipboardData(text: _setClipboard(searched));
                      await Clipboard.setData(data);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('クリップボードにコピーしました')),
                      );
                    },
                    child: const Text('情報をクリップボードにコピー'),
                  ),
                ];
              },
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => const Text('エラーが発生しました。'),
        ),
      ],
    );
  }

  String _setClipboard(Searched searched) {
    final String text =
        '『${searched.title}』\n${searched.enterYear.displayName}年度入学／${searched.course.displayName}\n名前：${searched.author}\n'
        '---------\nカテゴリ1：${searched.category1.displayName}>${searched.subCategory1.displayName}\n'
        'カテゴリ2：${searched.category2.displayName}>${searched.subCategory2.displayName}';
    return text;
  }
}
