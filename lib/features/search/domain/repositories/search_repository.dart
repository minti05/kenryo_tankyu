import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/search/domain/models/search.dart';
import 'package:kenryo_tankyu/features/search/domain/models/search_result.dart';

abstract class SearchRepository {
  Future<SearchResult?> search({
    required Search params,
    int page = 0,
    int? hitsPerPage,
  });

  Future<List<Searched>> getRandomWorks({
    required int count,
    required int maxItems,
  });
}
