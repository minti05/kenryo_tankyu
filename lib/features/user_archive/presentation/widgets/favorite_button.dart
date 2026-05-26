import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/providers/user_archive_providers.dart';

/// 全画面共通の「お気に入り」ボタン。
/// AsyncValue.isLoading を監視して、通信中の連打防止と視覚的フィードバックを行います。
class FavoriteButton extends ConsumerStatefulWidget {
  final Searched searched;
  final bool isLarge;

  const FavoriteButton({
    super.key,
    required this.searched,
    this.isLarge = false,
  });

  @override
  ConsumerState<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends ConsumerState<FavoriteButton> {
  // 楽観的UIのためのローカル状態
  bool? _isFavoriteLocal;
  int? _likesLocal;

  @override
  void didUpdateWidget(FavoriteButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 親から渡される likes が更新されたタイミングで楽観的な上書きを解除する。
    // これにより、通信完了→SQLite再読み込み完了の間に一瞬元の値に戻る
    // フリッカーを防ぐ。
    if (widget.searched.likes != oldWidget.searched.likes) {
      _likesLocal = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteState =
        ref.watch(userIsFavoriteStateProvider(widget.searched.documentID));

    // 通信完了後にローカル状態をリセット。
    // _likesLocal はエラー時のみここでリセットし、成功時は
    // didUpdateWidget で親の likes が更新されたタイミングでリセットする。
    if (!favoriteState.isLoading) {
      _isFavoriteLocal = null;
      if (favoriteState.hasError) {
        _likesLocal = null;
      }
    }

    final isFavorite = _isFavoriteLocal ??
        favoriteState.asData?.value ??
        widget.searched.isFavorite;
    final likes = _likesLocal ?? widget.searched.likes;
    final isLoading = favoriteState.isLoading;

    final color =
        isFavorite ? Colors.red : Theme.of(context).colorScheme.onSurface;
    final icon = isFavorite ? Icons.favorite : Icons.favorite_border;

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: widget.isLarge ? 28 : 24),
        if (!widget.searched.isCached) ...[
          const SizedBox(height: 4),
          Text(
            likes.toString(),
            style: TextStyle(
              color: color,
              fontSize: widget.isLarge ? 14 : 12,
            ),
          ),
        ],
      ],
    );

    final buttonBase = Opacity(
      opacity: isLoading ? 0.5 : 1.0,
      child: widget.isLarge
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: color.withValues(alpha: 0.5)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: content,
            )
          : content,
    );

    return InkWell(
      onTap: isLoading
          ? null
          : () {
              // 楽観的UIの更新
              setState(() {
                _isFavoriteLocal = !isFavorite;
                _likesLocal = isFavorite ? likes - 1 : likes + 1;
              });
              ref
                  .read(userIsFavoriteStateProvider(widget.searched.documentID)
                      .notifier)
                  .toggle(widget.searched.documentID, context);
            },
      child: buttonBase,
    );
  }
}
