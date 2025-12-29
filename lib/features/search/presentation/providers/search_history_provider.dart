import 'package:kenryo_tankyu/features/search/presentation/providers/search_history_repository_provider.dart';
import 'package:kenryo_tankyu/features/search/domain/models/search.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_history_provider.g.dart';

// SearchHistoryController provider is removed. Use searchHistoryRepositoryProvider.

@riverpod
Future<List<Search>?> searchHistory(Ref ref) async {
  return await ref.watch(searchHistoryRepositoryProvider).getAllHistory();
}
