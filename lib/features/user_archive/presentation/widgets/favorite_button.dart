import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/providers/user_archive_providers.dart';

/// 全画面共通の「お気に入り」ボタン。
/// AsyncValue.isLoading を監視して、通信中の連打防止と視覚的フィードバックを行います。
class FavoriteButton extends ConsumerWidget {
  final Searched searched;
  final bool showLikes;
  final bool isLarge;

  const FavoriteButton({
    super.key,
    required this.searched,
    this.showLikes = true,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteState =
        ref.watch(userIsFavoriteStateProvider(searched.documentID));

    // データがない（初期状態など）場合は、モデルの初期値を使用する
    final isFavorite = favoriteState.asData?.value ?? searched.isFavorite;
    final isLoading = favoriteState.isLoading;

    final color =
        isFavorite ? Colors.red : Theme.of(context).colorScheme.onSurface;
    final icon = isFavorite ? Icons.favorite : Icons.favorite_border;

    if (isLarge) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.red),
                    )
                  : Icon(icon, color: color),
              onPressed: isLoading
                  ? null
                  : () => ref
                      .read(userIsFavoriteStateProvider(searched.documentID)
                          .notifier)
                      .toggle(searched.documentID, context),
            ),
            if (showLikes && !searched.isCached) ...[
              const SizedBox(height: 4),
              Text(
                searched.likes.toString(),
                style: TextStyle(color: color),
              ),
            ],
          ],
        ),
      );
    }

    // 小さいボタン表示（リスト画面など）
    return InkWell(
      onTap: isLoading
          ? null
          : () => ref
              .read(userIsFavoriteStateProvider(searched.documentID).notifier)
              .toggle(searched.documentID, context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isLoading ? color.withValues(alpha: 0.5) : color,
          ),
          if (showLikes && !searched.isCached)
            Text(
              searched.likes.toString(),
              style: TextStyle(
                color: isLoading ? color.withValues(alpha: 0.5) : color,
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }
}
