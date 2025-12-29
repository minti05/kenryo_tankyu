import 'package:kenryo_tankyu/features/search/data/datasources/search_history_data_source.dart';
import 'package:kenryo_tankyu/features/search/domain/models/search.dart';
import 'package:kenryo_tankyu/features/search/domain/repositories/search_history_repository.dart';

class SearchHistoryRepositoryImpl implements SearchHistoryRepository {
  final SearchHistoryDataSource _dataSource;
  SearchHistoryRepositoryImpl(this._dataSource);

  @override
  Future<void> deleteAllHistory() {
    return _dataSource.deleteAllHistory();
  }

  @override
  Future<List<Search>?> getAllHistory() {
    return _dataSource.getAllHistory();
  }

  @override
  Future<void> insertHistory(Search search) {
    return _dataSource.insertHistory(search);
  }
}
