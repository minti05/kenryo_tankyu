// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(searchHistoryDataSource)
const searchHistoryDataSourceProvider = SearchHistoryDataSourceProvider._();

final class SearchHistoryDataSourceProvider extends $FunctionalProvider<
    SearchHistoryDataSource,
    SearchHistoryDataSource,
    SearchHistoryDataSource> with $Provider<SearchHistoryDataSource> {
  const SearchHistoryDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'searchHistoryDataSourceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$searchHistoryDataSourceHash();

  @$internal
  @override
  $ProviderElement<SearchHistoryDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SearchHistoryDataSource create(Ref ref) {
    return searchHistoryDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchHistoryDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchHistoryDataSource>(value),
    );
  }
}

String _$searchHistoryDataSourceHash() =>
    r'cefca60f2848d1cc70192dc8f9fb67f5afd059dd';
