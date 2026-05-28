import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/providers/user_archive_providers.dart';

/// 全画面共通の「お気に入り」ボタン。
///
/// ハートアイコンの状態は楽観的に即時反映するが、
/// いいね数（likes）は Firestore への書き込みが確認された後にのみ更新する。
/// これにより、オフライン時にカウントが誤って加算・保持されるのを防ぐ。
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
  /// ハートアイコン用の楽観的ローカル状態（即時フィードバック）
  bool? _isFavoriteLocal;

  @override
  void didUpdateWidget(FavoriteButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 別の作品に切り替わった場合はリセット
    if (widget.searched.documentID != oldWidget.searched.documentID) {
      _isFavoriteLocal = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // 通信完了後（成功・失敗どちらも）にローカル状態をリセット
    // build メソッド内の直接変更を避け、ref.listen で安全に setState を呼ぶ
    ref.listen<AsyncValue<bool>>(
      userIsFavoriteStateProvider(widget.searched.documentID),
      (previous, next) {
        if (previous?.isLoading == true && !next.isLoading) {
          setState(() {
            _isFavoriteLocal = null;
          });
        }
      },
    );

    final favoriteState =
        ref.watch(userIsFavoriteStateProvider(widget.searched.documentID));

    final isFavorite = _isFavoriteLocal ??
        favoriteState.asData?.value ??
        widget.searched.isFavorite;

    // likes は Firestore 確認後に SQLite へ反映された値のみ使用（楽観的更新なし）
    final likes = widget.searched.likes;

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
              // ハートアイコンのみ楽観的に更新（counts は確認後に自動反映）
              setState(() {
                _isFavoriteLocal = !isFavorite;
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
