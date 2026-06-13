// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'krgp_remote_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(krgpRemoteDataSource)
final krgpRemoteDataSourceProvider = KrgpRemoteDataSourceProvider._();

final class KrgpRemoteDataSourceProvider extends $FunctionalProvider<
    KrgpRemoteDataSource,
    KrgpRemoteDataSource,
    KrgpRemoteDataSource> with $Provider<KrgpRemoteDataSource> {
  KrgpRemoteDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'krgpRemoteDataSourceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$krgpRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<KrgpRemoteDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  KrgpRemoteDataSource create(Ref ref) {
    return krgpRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KrgpRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KrgpRemoteDataSource>(value),
    );
  }
}

String _$krgpRemoteDataSourceHash() =>
    r'63367e30a8c2397a9cb960e9062dd4a6dd82ac23';
