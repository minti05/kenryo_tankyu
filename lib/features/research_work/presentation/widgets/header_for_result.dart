import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
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
      leading: Navigator.canPop(context)
          ? null
          : IconButton(
              icon: const Icon(Icons.home_outlined),
              onPressed: () => context.go('/home'),
            ),
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
                      final shareText = _buildShareText(searched);
                      await SharePlus.instance.share(
                        ShareParams(text: shareText),
                      );
                    },
                    child: const Text('共有する...'),
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

  String _buildShareText(Searched searched) {
    final url = 'https://tankyu-app.web.app/result/${searched.documentID}';
    return '『${searched.title}』\n'
        '${searched.enterYear.displayName}年度入学／${searched.course.displayName}\n'
        '名前：${searched.author}\n'
        '---------\n'
        'カテゴリ1：${searched.category1.displayName}>${searched.subCategory1.displayName}\n'
        'カテゴリ2：${searched.category2.displayName}>${searched.subCategory2.displayName}\n'
        '---------\n'
        '$url';
  }
}
