import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/providers/searched_provider.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/utils/share_helper.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/widgets/suggest_report/suggest_report_dialog.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/widgets/favorite_button.dart';

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
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: FavoriteButton(
                    searched: searched,
                    isLarge: true,
                    horizontal: true,
                  ),
                ),
                PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        onTap: () {
                          ref.read(forceReloadProvider.notifier).state = true;
                          ref.invalidate(
                              searchedItemProvider(searched.documentID));
                        },
                        child: Text('リロードする$cachedText'),
                      ),
                      PopupMenuItem(
                        onTap: () => Navigator.of(context)
                            .push(SuggestReportDialog(searched)),
                        child: const Text('情報の変更を提案'),
                      ),
                      PopupMenuItem(
                        onTap: () async =>
                            shareSearched(searched, context: context),
                        child: const Text('共有する...'),
                      ),
                    ];
                  },
                ),
              ],
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => const Text('エラーが発生しました。'),
        ),
      ],
    );
  }
}
