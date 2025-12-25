// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searched_history_db.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(searchedHistoryDataSource)
const searchedHistoryDataSourceProvider = SearchedHistoryDataSourceProvider._();

final class SearchedHistoryDataSourceProvider extends $FunctionalProvider<
    SearchedHistoryDataSource,
    SearchedHistoryDataSource,
    SearchedHistoryDataSource> with $Provider<SearchedHistoryDataSource> {
  const SearchedHistoryDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'searchedHistoryDataSourceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$searchedHistoryDataSourceHash();

  @$internal
  @override
  $ProviderElement<SearchedHistoryDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SearchedHistoryDataSource create(Ref ref) {
    return searchedHistoryDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchedHistoryDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchedHistoryDataSource>(value),
    );
  }
}

String _$searchedHistoryDataSourceHash() =>
    r'938604ae6226b56702dcf9c0b13c9b2eaeda9bbd';
