import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:kenryo_tankyu/features/research_work/data/repositories/research_work_repository_impl.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/providers/user_archive_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'searched_provider.g.dart';

final showFullScreenButtonProvider =
    StateProvider.autoDispose<bool>((ref) => true);

final isFullScreenProvider = StateProvider.autoDispose<bool>((ref) => false);

final isSameScreenProvider = StateProvider.autoDispose<bool>((ref) => false);

final forceReloadProvider = StateProvider.autoDispose<bool>((ref) => false);

@riverpod
class ResearchWork extends _$ResearchWork {
  @override
  Future<Searched> build(int documentID) async {
    final repository = ref.watch(researchWorkRepositoryProvider);
    final archiveRepo = ref.watch(userArchiveRepositoryProvider);
    final forceReload = ref.read(forceReloadProvider);

    Future<Searched> fetchFromServer() async {
      final data = await repository.getWork(documentID.toString());
      final isFavorite = await archiveRepo.getFavoriteState(documentID);
      final combined = data.copyWith(isFavorite: isFavorite, isCached: false);
      if (forceReload) {
        ref.read(forceReloadProvider.notifier).state = false;
      }
      await archiveRepo.insertHistory(combined);
      return combined;
    }

    final Searched result;
    if (forceReload) {
      result = await fetchFromServer();
    } else {
      final cached = await archiveRepo.getHistory(documentID);
      if (cached != null) {
        result = cached.copyWith(isCached: false);
        unawaited(archiveRepo.updateHistoryViewedAt(documentID));
      } else {
        result = await fetchFromServer();
      }
    }

    // キャッシュから取得した場合のみ陳腐化チェックを実施
    if (result.savedAt != null) {
      unawaited(_refreshLikesIfStale(documentID, result.savedAt!, result));
    }

    return result;
  }

  /// お気に入り操作後に UI を即時更新する（invalidate による再フェッチを使わない）
  void updateForFavoriteChange({required bool isFavorite, required int likes}) {
    state = state.whenData(
      (s) => s.copyWith(isFavorite: isFavorite, likes: likes),
    );
  }

  Future<void> _refreshLikesIfStale(
    int documentID,
    DateTime viewedAt,
    Searched current,
  ) async {
    if (DateTime.now().difference(viewedAt) < const Duration(days: 90)) return;

    if (!ref.mounted) return;
    ref.read(isRefreshingLikesProvider(documentID).notifier).set(true);

    try {
      final repository = ref.read(researchWorkRepositoryProvider);
      final archiveRepo = ref.read(userArchiveRepositoryProvider);
      final userId = FirebaseAuth.instance.currentUser?.uid;

      final latest = await repository.getWork(documentID.toString());
      final updated =
          latest.copyWith(isFavorite: current.isFavorite, isCached: false);

      if (!ref.mounted) return;
      state = AsyncData(updated);

      if (userId != null) {
        unawaited(archiveRepo.updateHistoryWork(documentID, updated));
      }
    } catch (_) {
      // バックグラウンド更新の失敗はサイレントに無視
    } finally {
      if (ref.mounted) {
        ref.read(isRefreshingLikesProvider(documentID).notifier).set(false);
      }
    }
  }
}

/// likes のバックグラウンド更新中かどうかを管理するProvider（スナックバー表示に使用）
@riverpod
class IsRefreshingLikes extends _$IsRefreshingLikes {
  @override
  bool build(int documentID) => false;

  // ignore: use_setters_to_change_properties
  void set(bool value) => state = value;
}

// 後方互換のエイリアス
final searchedItemProvider = researchWorkProvider;

final intProvider = StateProvider.autoDispose((ref) => 0);
final stringProvider = StateProvider.autoDispose<String>((ref) => '22202363');
