import 'package:kenryo_tankyu/features/search/domain/models/search.dart';

abstract class SearchHistoryRepository {
  Future<void> insertHistory(Search search);
  Future<List<Search>?> getAllHistory();
  Future<void> deleteAllHistory();
}
