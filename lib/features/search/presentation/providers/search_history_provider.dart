import 'package:kenryo_tankyu/features/search/data/datasources/search_history_db.dart';
import 'package:kenryo_tankyu/features/search/domain/models/search.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_history_provider.g.dart';

@riverpod
SearchHistoryController searchHistoryController(Ref ref) {
  return SearchHistoryController.instance;
}

@riverpod
Future<List<Search>?> searchHistory(Ref ref) async {
  return await SearchHistoryController.instance.getAllHistory();
}
