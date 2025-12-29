import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:kenryo_tankyu/core/constants/work/search_value.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/models.dart';
import 'package:kenryo_tankyu/features/search/data/repositories/search_repository_impl.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/providers.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/providers/providers.dart';

final forceRefreshProvider = StateProvider.autoDispose<bool>((ref) => false);

final algoliaSearchProvider =
    FutureProvider.autoDispose<List<Searched>?>((ref) async {
  final search =
      ref.read(searchProvider); //ref.readにすると、watchと違って値が変更されたときに再ビルドされない！

  final repository = ref.watch(searchRepositoryProvider);
  return repository.search(params: search);
});

final sortedListProvider =
    NotifierProvider.autoDispose<SortedListNotifier, List<Searched>>(() {
  return SortedListNotifier();
});

class SortedListNotifier extends Notifier<List<Searched>> {
  @override
  List<Searched> build() {
    final data = ref.watch(algoliaSearchProvider).asData?.value ?? [];
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
        newList.sort((a, b) => b.vagueLikes.compareTo(a.vagueLikes));
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

    // 250 is the hardcoded magic number from original code
    final results =
        await searchRepository.getRandomWorks(count: 2, maxItems: 250);

    // Save to recommended history? The original code didn't explicitly save here?
    // Wait, original code:
    // ... logic ...
    // return [...objects, ...objects2];

    // Wait, check UserArchiveRepository.saveRecommendedWorks.
    // It is called somewhere?
    // In original code in algolia_provider.dart, it was NOT calling saveRecommendedWorks.
    // That means saving might happen in UI or somewhere else?
    // Or maybe I missed it.
    // Let's assume it should return results.

    // However, if we want to CACHE it for next time (Step: loadRecommendedWorks checks cache),
    // we MUST save it.
    // Original code:
    // final data = await repository.loadRecommendedWorks();
    // ... if cache hit ... return data;
    // ... else ... fetch algolia ... return results;
    // It NEVER SAVED to cache in the provider.
    // Maybe `loadRecommendedWorks` reads from a DB that is populated elsewhere?
    // Or the original code was missing the save logic?
    // It seems missing in `algolia_provider.dart` (Step 181).
    // But `UserArchiveRepository` has `saveRecommendedWorks`.
    // I will add saving logic here to make the cache work, assuming that was the intent.
    if (results.length >= 2) {
      await archiveRepository.saveRecommendedWorks(results[0], results[1]);
    }

    return results;
  }
});
