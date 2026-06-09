import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:kenryo_tankyu/core/constants/work/search_value.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/search/data/repositories/search_repository_impl.dart';
import 'package:kenryo_tankyu/features/search/domain/models/search_result.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/search_provider.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/providers/user_archive_providers.dart';
import 'package:kenryo_tankyu/core/connectivity/connectivity_provider.dart';
import 'package:kenryo_tankyu/core/error/failures.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/search_history_provider.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/search_history_repository_provider.dart';

final forceRefreshProvider = StateProvider.autoDispose<bool>((ref) => false);

class SearchResultCacheNotifier extends Notifier<Map<int, SearchResult>> {
  @override
  Map<int, SearchResult> build() {
    ref.listen(searchProvider, (previous, next) {
      state = {};
    });
    return {};
  }

  SearchResult? get(int page) => state[page];

  void set(int page, SearchResult result) {
    state = {...state, page: result};
  }
}

final searchResultCacheProvider = NotifierProvider.autoDispose<
    SearchResultCacheNotifier,
    Map<int, SearchResult>>(SearchResultCacheNotifier.new);

class SearchPageNotifier extends Notifier<int> {
  @override
  int build() {
    ref.listen(searchProvider, (previous, next) {
      state = 0;
    });
    return 0;
  }

  void setPage(int page) => state = page;
}

final searchPageProvider =
    NotifierProvider.autoDispose<SearchPageNotifier, int>(() {
  return SearchPageNotifier();
});

final algoliaSearchProvider =
    FutureProvider.autoDispose<SearchResult?>((ref) async {
  final isConnected = ref.watch(isConnectedProvider);
  if (!isConnected) {
    throw const NetworkFailure();
  }

  final search =
      ref.read(searchProvider); //ref.readにすると、watchと違って値が変更されたときに再ビルドされない！

  if (search.isEmpty) return null;

  final page = ref.watch(searchPageProvider);
  final cache = ref.watch(searchResultCacheProvider.notifier);

  final cached = cache.get(page);
  if (cached != null) {
    return cached;
  }

  final repository = ref.watch(searchRepositoryProvider);
  final historyRepository = ref.watch(searchHistoryRepositoryProvider);

  final result = await repository.search(params: search, page: page);

  if (result != null && page == 0) {
    // Save history side effect (first page only)
    final searchWithMeta =
        search.copyWith(savedAt: DateTime.now(), numberOfHits: result.nbHits);
    try {
      await historyRepository.insertHistory(searchWithMeta);
      ref.read(searchHistoryCacheProvider.notifier).addOrUpdate(searchWithMeta);
    } catch (e) {
      debugPrint('Failed to save search history: $e');
    }
  }

  if (result == null && page > 0) {
    return SearchResult(hits: [], page: page, nbPages: page, nbHits: 0);
  }

  if (result != null) {
    cache.set(page, result);
  }

  return result;
});

final sortedListProvider =
    NotifierProvider.autoDispose<SortedListNotifier, List<Searched>>(() {
  return SortedListNotifier();
});

class SortedListNotifier extends Notifier<List<Searched>> {
  @override
  List<Searched> build() {
    final data = ref.watch(algoliaSearchProvider).asData?.value?.hits ?? [];
    return data;
  }

  void sortList(SortType sortType) {
    final List<Searched> newList = [...state]; // コピーを作る
    switch (sortType) {
      case SortType.newOrder:
        newList.sort((a, b) =>
            b.enterYear.displayName.compareTo(a.enterYear.displayName));
        debugPrint('新しい順で並び替えます');
        break;
      case SortType.oldOrder:
        newList.sort((a, b) =>
            a.enterYear.displayName.compareTo(b.enterYear.displayName));
        debugPrint('古い順で並び替えます');
        break;
      case SortType.likeOrder:
        newList.sort((a, b) => b.likes.compareTo(a.likes));
        debugPrint('いいね順で並び替えます');
        break;
    }
    state = newList;
  }
}

final randomAlgoliaSearchProvider =
    FutureProvider.autoDispose<List<Searched>>((ref) async {
  final isForce = ref.read(forceRefreshProvider);
  final archiveRepository = ref.watch(userArchiveRepositoryProvider);
  final searchRepository = ref.watch(searchRepositoryProvider);

  final data = await archiveRepository.loadRecommendedWorks();
  debugPrint(data.toString());
  if (isForce == false &&
      data.isNotEmpty &&
      data[0].savedAt != null &&
      data[0].savedAt!.difference(DateTime.now()).inDays < 3) {
    //キャッシュが3日以内のものであればそれを返す。
    debugPrint('キャッシュから取得します');
    ref.read(forceRefreshProvider.notifier).state = false;
    return data;
  } else {
    debugPrint('Algoliaから取得します');

    final isConnected = ref.read(isConnectedProvider);
    if (!isConnected) {
      throw const NetworkFailure();
    }

    // 250 is the hardcoded magic number from original code
    final results =
        await searchRepository.getRandomWorks(count: 2, maxItems: 250);

    if (results.length >= 2) {
      await archiveRepository.saveRecommendedWorks(results[0], results[1]);
    }

    return results;
  }
});
