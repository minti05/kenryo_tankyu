// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(searchHistory)
const searchHistoryProvider = SearchHistoryProvider._();

final class SearchHistoryProvider extends $FunctionalProvider<
        AsyncValue<List<Search>?>, List<Search>?, FutureOr<List<Search>?>>
    with $FutureModifier<List<Search>?>, $FutureProvider<List<Search>?> {
  const SearchHistoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'searchHistoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$searchHistoryHash();

  @$internal
  @override
  $FutureProviderElement<List<Search>?> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Search>?> create(Ref ref) {
    return searchHistory(ref);
  }
}

String _$searchHistoryHash() => r'190059a1cf94a37129ccf87ea95d045eee0e5c5c';
