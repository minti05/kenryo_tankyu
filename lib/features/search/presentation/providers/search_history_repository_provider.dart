import 'package:kenryo_tankyu/features/search/data/datasources/search_history_data_source.dart';
import 'package:kenryo_tankyu/features/search/data/repositories/search_history_repository_impl.dart';
import 'package:kenryo_tankyu/features/search/domain/repositories/search_history_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_history_repository_provider.g.dart';

@riverpod
SearchHistoryRepository searchHistoryRepository(Ref ref) {
  final dataSource = ref.watch(searchHistoryDataSourceProvider);
  return SearchHistoryRepositoryImpl(dataSource);
}
