import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:kenryo_tankyu/features/search/domain/models/search.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/search_history_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_history_provider.g.dart';

@Riverpod(keepAlive: true)
class SearchHistoryCache extends _$SearchHistoryCache {
  @override
  Future<List<Search>?> build() async => null;

  Future<void> initialize(String userId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(searchHistoryRepositoryProvider).getAllHistory(),
    );
  }

  Future<void> reload() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;
    await initialize(userId);
  }

  void addOrUpdate(Search search) {
    final current = state.asData?.value ?? [];
    final idx = current.indexWhere((s) => _isSameSearch(s, search));
    if (idx >= 0) {
      final updated = List<Search>.from(current)..removeAt(idx);
      state = AsyncData([search, ...updated]);
    } else {
      state = AsyncData([search, ...current]);
    }
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
