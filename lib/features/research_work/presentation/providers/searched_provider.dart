import 'package:flutter_riverpod/legacy.dart';
import 'package:kenryo_tankyu/features/research_work/data/repositories/research_work_repository_impl.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/providers/user_archive_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'searched_provider.g.dart';

//全画面表示ボタンを表示するかしないかを管理するprovider
final showFullScreenButtonProvider =
    StateProvider.autoDispose<bool>((ref) => true);

//全画面か詳細画面かどうかを管理するprovider。IndexedStackに使用
final isFullScreenProvider = StateProvider.autoDispose<bool>((ref) => false);

//同じ探究作品を見ている最中なのかどうかを管理するprovider
//このproviderを導入することによって、全画面に切り替えたときに不用意な再ビルドを防ぐ。
final isSameScreenProvider = StateProvider.autoDispose<bool>((ref) => false);

final forceReloadProvider = StateProvider.autoDispose<bool>((ref) => false);

@riverpod
Future<Searched> researchWork(Ref ref, int documentID) async {
  final repository = ref.watch(researchWorkRepositoryProvider);
  final archiveRepo = ref.watch(userArchiveRepositoryProvider);
  final forceReload = ref.read(forceReloadProvider);

  // Helper to fetch from server and update history
  Future<Searched> fetchFromServer() async {
    final data = await repository.getWork(documentID.toString());
    final isFavorite = await archiveRepo.getFavoriteState(documentID);
    final combined = data.copyWith(isFavorite: isFavorite, isCached: false);

    // reset force flag if it was true? Legacy code did this.
    if (forceReload) {
      ref.read(forceReloadProvider.notifier).state = false;
    }

    // Update history
    await archiveRepo.insertHistory(combined);
    return combined;
  }

  if (forceReload) {
    return fetchFromServer();
  } else {
    final cached = await archiveRepo.getHistory(documentID);
    if (cached != null) {
      return cached;
    } else {
      return fetchFromServer();
    }
  }
}

// Keeping the old name for backward compatibility or refactoring UI in next steps
final searchedItemProvider = researchWorkProvider;

//choiceChipの選択肢を管理する簡易的なProvider
final intProvider = StateProvider.autoDispose((ref) => 0);
final stringProvider =
    StateProvider.autoDispose<String>((ref) => '22202363'); //TODO 初期値これ升田さんのやつ。
