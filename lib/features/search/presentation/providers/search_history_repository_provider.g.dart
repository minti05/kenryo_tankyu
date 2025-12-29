// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(searchHistoryRepository)
const searchHistoryRepositoryProvider = SearchHistoryRepositoryProvider._();

final class SearchHistoryRepositoryProvider extends $FunctionalProvider<
    SearchHistoryRepository,
    SearchHistoryRepository,
    SearchHistoryRepository> with $Provider<SearchHistoryRepository> {
  const SearchHistoryRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'searchHistoryRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$searchHistoryRepositoryHash();

  @$internal
  @override
  $ProviderElement<SearchHistoryRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SearchHistoryRepository create(Ref ref) {
    return searchHistoryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchHistoryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchHistoryRepository>(value),
    );
  }
}

String _$searchHistoryRepositoryHash() =>
    r'3abe45bdd4e08b090bac2dd40587863e6a77016f';
