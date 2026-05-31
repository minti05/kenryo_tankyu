// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browsing_history_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(browsingHistoryDataSource)
const browsingHistoryDataSourceProvider = BrowsingHistoryDataSourceProvider._();

final class BrowsingHistoryDataSourceProvider extends $FunctionalProvider<
    BrowsingHistoryDataSource,
    BrowsingHistoryDataSource,
    BrowsingHistoryDataSource> with $Provider<BrowsingHistoryDataSource> {
  const BrowsingHistoryDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'browsingHistoryDataSourceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$browsingHistoryDataSourceHash();

  @$internal
  @override
  $ProviderElement<BrowsingHistoryDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BrowsingHistoryDataSource create(Ref ref) {
    return browsingHistoryDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BrowsingHistoryDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BrowsingHistoryDataSource>(value),
    );
  }
}

String _$browsingHistoryDataSourceHash() =>
    r'9e807e797f910facab19095c99556d247feea364';
