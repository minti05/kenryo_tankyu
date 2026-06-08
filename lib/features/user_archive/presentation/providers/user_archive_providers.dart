import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:kenryo_tankyu/core/constants/work/info_value.dart';
import 'package:kenryo_tankyu/core/error/failures.dart';
import 'package:kenryo_tankyu/features/auth/presentation/providers/auth_provider.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/providers/searched_provider.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/browsing_history_data_source.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/favorites_remote_data_source.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/pdf_local_data_source.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/recommended_works_local_data_source.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/user_archive_remote_data_source.dart';
import 'package:kenryo_tankyu/features/user_archive/data/repositories/user_archive_repository_impl.dart';
import 'package:kenryo_tankyu/features/user_archive/domain/repositories/user_archive_repository.dart';
import 'package:kenryo_tankyu/presentation/widget/error_dialog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_archive_providers.g.dart';

@riverpod
UserArchiveRepository userArchiveRepository(Ref ref) {
  final browsingHistoryDataSource =
      ref.watch(browsingHistoryDataSourceProvider);
  final favoritesDataSource = ref.watch(favoritesRemoteDataSourceProvider);
  final pdfDataSource = ref.watch(pdfLocalDataSourceProvider);
  final recommendedDataSource =
      ref.watch(recommendedWorksLocalDataSourceProvider);
  final remoteDataSource = ref.watch(userArchiveRemoteDataSourceProvider);

  return UserArchiveRepositoryImpl(
    browsingHistoryDataSource,
    favoritesDataSource,
    pdfDataSource,
    recommendedDataSource,
    remoteDataSource,
  );
}

@Riverpod(keepAlive: true)
class FavoriteIdsCache extends _$FavoriteIdsCache {
  @override
  Future<Set<int>> build() async {
    // auth ストリームの最初の値を待つ。
    // ログイン/ログアウト時に authStateChangesProvider が変わると自動で再実行される。
    final user = await ref.watch(authStateChangesProvider.future);
    if (user == null || !user.emailVerified) return {};
    return await ref
        .read(favoritesRemoteDataSourceProvider)
        .getFavoriteIds(user.uid);
  }

  Future<void> add(int id) async {
    try {
      final current = await future;
      state = AsyncData({...current, id});
    } catch (_) {
      state = AsyncData({id});
    }
  }

  Future<void> remove(int id) async {
    try {
      final current = await future;
      state = AsyncData(current.difference({id}));
    } catch (_) {
      state = const AsyncData({});
    }
  }
}

/// ボタン連打防止を管理するProvider
@riverpod
class AbleChangeFavorite extends _$AbleChangeFavorite {
  @override
  bool build() => true;

  void set(bool value) => state = value;
}

@riverpod
class UserIsFavoriteState extends _$UserIsFavoriteState {
  @override
  Future<bool> build(int documentID) async {
    final repository = ref.watch(userArchiveRepositoryProvider);
    return repository.getFavoriteState(documentID);
  }

  /// お気に入り状態を反転させる
  /// [documentID] 対象のドキュメントID
  /// [context] エラーダイアログ表示用。Widget側でmountedチェックをしてから渡すこと。
  Future<void> toggle(int documentID, BuildContext context) async {
    // すでに処理中の場合は何もしない（連打防止）
    if (state.isLoading) return;

    final repository = ref.read(userArchiveRepositoryProvider);
    final previousState = state;
    final bool currentIsFavorite = state.asData?.value ?? false;
    final bool nextIsFavorite = !currentIsFavorite;

    // ローディング状態に移行
    state = const AsyncLoading<bool>();

    state = await AsyncValue.guard(() async {
      await repository.changeFavoriteState(documentID, nextIsFavorite);

      // インメモリキャッシュを即時更新
      if (nextIsFavorite) {
        ref.read(favoriteIdsCacheProvider.notifier).add(documentID);
      } else {
        ref.read(favoriteIdsCacheProvider.notifier).remove(documentID);
      }

      // searchedHistoryProvider(false) は favoriteIdsCacheProvider を watch しているため
      // FavoriteIdsCache 更新で自動再計算される。お気に入りタブのみ明示的に無効化する。
      ref.invalidate(searchedHistoryProvider(true));

      // researchWork の state を直接更新（invalidate だと browsing_history の
      // キャッシュ更新タイミングと競合して古い likes が表示されるため）
      final current = ref.read(researchWorkProvider(documentID)).asData?.value;
      if (current != null) {
        final newLikes =
            (current.likes + (nextIsFavorite ? 1 : -1)).clamp(0, 999999);
        ref
            .read(researchWorkProvider(documentID).notifier)
            .updateForFavoriteChange(
              isFavorite: nextIsFavorite,
              likes: newLikes,
            );
      }

      return nextIsFavorite;
    });

    // エラーハンドリング
    if (state.hasError && context.mounted) {
      final error = state.error;
      if (error is NetworkFailure) {
        // ネットワークエラーはSnackBarで軽く通知（モーダルでUIを塞がない）
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.wifi_off, color: Colors.white, size: 18),
                SizedBox(width: 8),
                Text('インターネットに接続できませんでした'),
              ],
            ),
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else if (error is Failure) {
        showErrorDialog(context, error);
      } else {
        showErrorDialog(context, UnknownFailure(message: error.toString()));
      }
      // エラー時は前の状態に戻す
      state = previousState;
    }
  }
}

/// 無限スクロール対応の閲覧履歴 / お気に入りリスト。
/// [onlyShowFavorite] が true のときはお気に入りのみ表示する。
/// 初期ロードは20件。[fetchMore] を呼ぶと追加20件を末尾に追加する。
@riverpod
class SearchedHistoryNotifier extends _$SearchedHistoryNotifier {
  static const _pageSize = 20;

  /// まだ取得できるページがあるか
  bool _hasMore = true;

  /// 追加ロード中の多重呼び出しを防ぐフラグ
  bool _isFetchingMore = false;

  bool get hasMore => _hasMore;

  @override
  Future<List<Searched>> build(bool onlyShowFavorite) async {
    _hasMore = true;
    _isFetchingMore = false;

    // お気に入り変更をインプレース更新（ref.watchにするとリスト全体がリセットされる）
    ref.listen(favoriteIdsCacheProvider, (previous, next) {
      final favoriteIds = next.asData?.value;
      if (favoriteIds == null) return;
      final current = state.asData?.value;
      if (current == null) return;
      if (onlyShowFavorite) {
        state = AsyncData(
          current
              .where((item) => favoriteIds.contains(item.documentID))
              .toList(),
        );
      } else {
        state = AsyncData(
          current
              .map((item) => item.copyWith(
                  isFavorite: favoriteIds.contains(item.documentID)))
              .toList(),
        );
      }
    });

    // 初回のみ読み取る（再ビルドを防ぐためreadを使用）
    final favoriteIds = await ref.read(favoriteIdsCacheProvider.future);

    final items = await _fetchPage(0, favoriteIds);
    _hasMore = items.length == _pageSize;
    return items;
  }

  Future<void> fetchMore() async {
    if (!_hasMore || _isFetchingMore) return;
    final current = state.asData?.value;
    if (current == null) return;

    _isFetchingMore = true;
    try {
      final favoriteIds =
          ref.read(favoriteIdsCacheProvider).asData?.value ?? {};
      final newItems = await _fetchPage(current.length, favoriteIds);
      if (!ref.mounted) return;
      _hasMore = newItems.length == _pageSize;
      state = AsyncData([...current, ...newItems]);
    } finally {
      _isFetchingMore = false;
    }
  }

  Future<List<Searched>> _fetchPage(int offset, Set<int> favoriteIds) async {
    final repository = ref.read(userArchiveRepositoryProvider);
    if (onlyShowFavorite) {
      if (favoriteIds.isEmpty) return [];
      final items = await repository.getFavoriteHistoryPaged(
        favoriteIds,
        from: offset,
        limit: _pageSize,
      );
      return items ?? [];
    } else {
      final items = await repository.getHistoryPaged(
        from: offset,
        limit: _pageSize,
      );
      if (items == null) return [];
      return items
          .map(
              (h) => h.copyWith(isFavorite: favoriteIds.contains(h.documentID)))
          .toList();
    }
  }
}

@riverpod
class HistoryController extends _$HistoryController {
  @override
  void build() {}

  Future<void> deleteHistory(int id, {bool isFavorite = false}) async {
    final repository = ref.read(userArchiveRepositoryProvider);
    if (isFavorite) {
      await repository.deleteHistoryWithFavorite(id);
      if (!ref.mounted) return;
      ref.read(favoriteIdsCacheProvider.notifier).remove(id);
      // (false) は FavoriteIdsCache の remove により自動再計算される
      ref.invalidate(searchedHistoryProvider(true));
    } else {
      await repository.deleteHistory(id);
      if (!ref.mounted) return;
      ref.invalidate(searchedHistoryProvider(false));
    }
  }

  Future<void> deleteAllHistory() async {
    final repository = ref.read(userArchiveRepositoryProvider);
    await repository.deleteAllHistory();
    if (!ref.mounted) return;
    ref.invalidate(searchedHistoryProvider(false));
    ref.invalidate(searchedHistoryProvider(true));
  }

  Future<void> deleteHistoryBefore(DateTime date) async {
    final repository = ref.read(userArchiveRepositoryProvider);
    await repository.deleteHistoryBefore(date);
    if (!ref.mounted) return;
    ref.invalidate(searchedHistoryProvider(false));
    ref.invalidate(searchedHistoryProvider(true));
  }
}

@riverpod
class PdfCacheController extends _$PdfCacheController {
  @override
  void build() {}

  Future<void> deleteAll() async {
    final repository = ref.read(userArchiveRepositoryProvider);
    await repository.deleteAllPdfCache();
  }

  Future<void> deleteBefore(DateTime date) async {
    final repository = ref.read(userArchiveRepositoryProvider);
    await repository.deletePdfCacheBefore(date);
  }
}

@riverpod
Future<Uint8List?> pdf(Ref ref, String id, EnterYear enterYear) async {
  final repository = ref.watch(userArchiveRepositoryProvider);
  return repository.getPdf(id, enterYear);
}

@riverpod
Future<Uint8List?> teacherPdf(Ref ref, String id) async {
  final repository = ref.watch(userArchiveRepositoryProvider);
  return repository.getTeacherPdf(id);
}
