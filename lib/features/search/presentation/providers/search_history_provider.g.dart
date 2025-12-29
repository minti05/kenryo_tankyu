// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(searchHistoryController)
const searchHistoryControllerProvider = SearchHistoryControllerProvider._();

final class SearchHistoryControllerProvider extends $FunctionalProvider<
    SearchHistoryController,
    SearchHistoryController,
    SearchHistoryController> with $Provider<SearchHistoryController> {
  const SearchHistoryControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'searchHistoryControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$searchHistoryControllerHash();

  @$internal
  @override
  $ProviderElement<SearchHistoryController> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SearchHistoryController create(Ref ref) {
    return searchHistoryController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchHistoryController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchHistoryController>(value),
    );
  }
}

String _$searchHistoryControllerHash() =>
    r'15f335bb6c9b5def48d30d3a003b5f6ac153fbc9';

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

String _$searchHistoryHash() => r'cec9d35b83982d940d7d02c8fcfde9f66cff4b02';
