// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(searchHistoryDataSource)
final searchHistoryDataSourceProvider = SearchHistoryDataSourceProvider._();

final class SearchHistoryDataSourceProvider extends $FunctionalProvider<
    SearchHistoryDataSource,
    SearchHistoryDataSource,
    SearchHistoryDataSource> with $Provider<SearchHistoryDataSource> {
  SearchHistoryDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'searchHistoryDataSourceProvider',
          isAutoDispose: false,
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
    r'9b1cb3506770eb4c2c7dcfd2928cda0b74aea32a';
