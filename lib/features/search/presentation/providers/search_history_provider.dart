import 'dart:convert';

import 'package:kenryo_tankyu/features/search/domain/models/search.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/search_history_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_history_provider.g.dart';

@Riverpod(keepAlive: true)
class SearchHistoryCache extends _$SearchHistoryCache {
  @override
  Future<List<Search>?> build() async => null;

  Future<void> initialize() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(searchHistoryRepositoryProvider).getAllHistory(),
    );
  }

  Future<void> reload() async {
    await initialize();
  }

  void addOrUpdate(Search search) {
    state.whenData((current) {
      final list = current ?? [];
      final idx = list.indexWhere((s) => _isSameSearch(s, search));
      if (idx >= 0) {
        final updated = List<Search>.from(list)..removeAt(idx);
        state = AsyncData([search, ...updated]);
      } else {
        state = AsyncData([search, ...list]);
      }
    });
  }

  void clear() => state = const AsyncData(null);

  bool _isSameSearch(Search a, Search b) =>
      a.category == b.category &&
      a.subCategory == b.subCategory &&
      a.enterYear == b.enterYear &&
      a.eventName == b.eventName &&
      a.course == b.course &&
      jsonEncode(a.searchWord) == jsonEncode(b.searchWord);
}
