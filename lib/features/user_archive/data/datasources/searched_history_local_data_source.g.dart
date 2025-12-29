// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searched_history_local_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(searchedHistoryLocalDataSource)
const searchedHistoryLocalDataSourceProvider =
    SearchedHistoryLocalDataSourceProvider._();

final class SearchedHistoryLocalDataSourceProvider extends $FunctionalProvider<
        SearchedHistoryLocalDataSource,
        SearchedHistoryLocalDataSource,
        SearchedHistoryLocalDataSource>
    with $Provider<SearchedHistoryLocalDataSource> {
  const SearchedHistoryLocalDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'searchedHistoryLocalDataSourceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$searchedHistoryLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<SearchedHistoryLocalDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SearchedHistoryLocalDataSource create(Ref ref) {
    return searchedHistoryLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchedHistoryLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<SearchedHistoryLocalDataSource>(value),
    );
  }
}

String _$searchedHistoryLocalDataSourceHash() =>
    r'fd8b6e9f2b95b8e56c38ee5ce0a2230674dc807d';
