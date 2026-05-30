import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';

part 'search_result.freezed.dart';

@freezed
abstract class SearchResult with _$SearchResult {
  const factory SearchResult({
    required List<Searched> hits,
    required int page,
    required int nbPages,
    required int nbHits,
  }) = _SearchResult;

  const SearchResult._();

  bool get isLastPage => page >= nbPages - 1;
}
