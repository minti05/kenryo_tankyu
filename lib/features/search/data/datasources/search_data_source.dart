import 'package:algoliasearch/algoliasearch.dart';
import 'package:kenryo_tankyu/features/search/data/algolia.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_data_source.g.dart';

abstract class SearchDataSource {
  Future<SearchResponse> searchIndex({required SearchForHits request});
}

class SearchDataSourceImpl implements SearchDataSource {
  SearchDataSourceImpl(this._client);
  final SearchClient _client;

  @override
  Future<SearchResponse> searchIndex({required SearchForHits request}) {
    return _client.searchIndex(request: request);
  }
}

@riverpod
SearchDataSource searchDataSource(Ref ref) {
  // Application.algolia is static, so we just use it.
  // Ideally, we might want to inject the client for testing, but adhering to existing approach:
  return SearchDataSourceImpl(Application.algolia);
}
