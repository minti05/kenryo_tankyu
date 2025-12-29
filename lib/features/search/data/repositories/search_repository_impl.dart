import 'dart:math';

import 'package:algoliasearch/algoliasearch.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/models.dart';
import 'package:kenryo_tankyu/features/search/data/datasources/search_data_source.dart';
import 'package:kenryo_tankyu/features/search/domain/models/models.dart';
import 'package:kenryo_tankyu/features/search/domain/repositories/search_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_repository_impl.g.dart';

class SearchRepositoryImpl implements SearchRepository {
  SearchRepositoryImpl(this._dataSource);

  final SearchDataSource _dataSource;

  @override
  Future<List<Searched>?> search({
    required Search params,
    int page = 0,
    int? hitsPerPage,
  }) async {
    final String searchWord =
        params.searchWord.map<String>((String value) => value).join(',');
    final String filter = _buildFilter(params);

    final queryHits = SearchForHits(
      indexName: 'firestore',
      query: searchWord,
      filters: filter == '' ? null : filter,
      page: page,
      hitsPerPage: hitsPerPage,
    );

    try {
      final SearchResponse response =
          await _dataSource.searchIndex(request: queryHits);
      final List<Hit> hits = response.hits;
      if (hits.isEmpty) {
        return null;
      } else {
        return hits.map((object) {
          return Searched.fromAlgolia(object, false);
        }).toList();
      }
    } catch (error, stackTrace) {
      return Future.error(error, stackTrace);
    }
  }

  @override
  Future<List<Searched>> getRandomWorks({
    required int count,
    required int maxItems,
  }) async {
    // Note: This logic roughly mimics the original random algolia provider behavior details
    // It blindly fetches multiple times.
    List<Searched> results = [];

    // Generating distinct random pages
    final Set<int> pages = {};
    while (pages.length < count) {
      pages.add(Random().nextInt(maxItems));
    }

    for (final page in pages) {
      final query = SearchForHits(
        indexName: 'firestore',
        query: '',
        page: page,
        hitsPerPage: 1,
      );
      final resp = await _dataSource.searchIndex(request: query);
      final hits = resp.hits;
      results.addAll(hits.map((e) => Searched.fromAlgolia(e, false)));
    }
    return results;
  }

  String _buildFilter(Search searchState) {
    String str = '';
    searchState.subCategory.name != 'none'
        ? str +=
            'AND (subCategory1:${searchState.subCategory.name} OR subCategory2:${searchState.subCategory.name})'
        : searchState.category.name != 'none'
            ? str +=
                'AND (category1:${searchState.category.name} OR category2:${searchState.category.name})'
            : null;
    searchState.enterYear.name != 'undefined'
        ? str += ' AND enterYear:${searchState.enterYear.displayName}'
        : null;
    searchState.course.name != 'undefined'
        ? str += ' AND course:${searchState.course.name}'
        : null;
    str != '' ? str = str.substring(4, str.length) : null;
    return str;
  }
}

@riverpod
SearchRepository searchRepository(Ref ref) {
  final dataSource = ref.watch(searchDataSourceProvider);
  return SearchRepositoryImpl(dataSource);
}
