// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_remote_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(favoritesRemoteDataSource)
const favoritesRemoteDataSourceProvider = FavoritesRemoteDataSourceProvider._();

final class FavoritesRemoteDataSourceProvider extends $FunctionalProvider<
    FavoritesRemoteDataSource,
    FavoritesRemoteDataSource,
    FavoritesRemoteDataSource> with $Provider<FavoritesRemoteDataSource> {
  const FavoritesRemoteDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'favoritesRemoteDataSourceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$favoritesRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<FavoritesRemoteDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FavoritesRemoteDataSource create(Ref ref) {
    return favoritesRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FavoritesRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FavoritesRemoteDataSource>(value),
    );
  }
}

String _$favoritesRemoteDataSourceHash() =>
    r'2ae6a14e1ee6ff971412884f9b4c9eef38b16b6b';
