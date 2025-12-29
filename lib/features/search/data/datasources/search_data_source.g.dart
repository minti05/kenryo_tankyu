// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(searchDataSource)
const searchDataSourceProvider = SearchDataSourceProvider._();

final class SearchDataSourceProvider extends $FunctionalProvider<
    SearchDataSource,
    SearchDataSource,
    SearchDataSource> with $Provider<SearchDataSource> {
  const SearchDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'searchDataSourceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$searchDataSourceHash();

  @$internal
  @override
  $ProviderElement<SearchDataSource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SearchDataSource create(Ref ref) {
    return searchDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchDataSource>(value),
    );
  }
}

String _$searchDataSourceHash() => r'16be4c878814d1cb91b91ac98dc2182643eeb540';
