import 'package:firebase_auth/firebase_auth.dart';
import 'package:kenryo_tankyu/core/error/error_mapper.dart';
import 'package:kenryo_tankyu/features/search/data/datasources/search_history_data_source.dart';
import 'package:kenryo_tankyu/features/search/domain/models/search.dart';
import 'package:kenryo_tankyu/features/search/domain/repositories/search_history_repository.dart';

class SearchHistoryRepositoryImpl
    with ErrorMapper
    implements SearchHistoryRepository {
  final SearchHistoryDataSource _dataSource;
  SearchHistoryRepositoryImpl(this._dataSource);

  @override
  Future<void> deleteAllHistory() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;
    try {
      await _dataSource.deleteAllHistory(userId);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<List<Search>?> getAllHistory() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return null;
    try {
      return await _dataSource.getAllHistory(userId);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<void> insertHistory(Search search) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;
    try {
      await _dataSource.insertHistory(userId, search);
    } catch (e) {
      throw mapException(e);
    }
  }
}
