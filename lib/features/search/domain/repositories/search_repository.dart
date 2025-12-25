import 'package:kenryo_tankyu/features/research_work/domain/models/models.dart';
import 'package:kenryo_tankyu/features/search/domain/models/models.dart';

abstract class SearchRepository {
  Future<List<Searched>?> search({
    required Search params,
    int page = 0,
    int? hitsPerPage,
  });

  Future<List<Searched>> getRandomWorks({
    required int count,
    required int maxItems,
  });
}
