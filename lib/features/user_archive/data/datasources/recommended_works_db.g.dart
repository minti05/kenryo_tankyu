// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommended_works_db.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(recommendedWorksDataSource)
const recommendedWorksDataSourceProvider =
    RecommendedWorksDataSourceProvider._();

final class RecommendedWorksDataSourceProvider extends $FunctionalProvider<
    RecommendedWorksDataSource,
    RecommendedWorksDataSource,
    RecommendedWorksDataSource> with $Provider<RecommendedWorksDataSource> {
  const RecommendedWorksDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'recommendedWorksDataSourceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$recommendedWorksDataSourceHash();

  @$internal
  @override
  $ProviderElement<RecommendedWorksDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RecommendedWorksDataSource create(Ref ref) {
    return recommendedWorksDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecommendedWorksDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecommendedWorksDataSource>(value),
    );
  }
}

String _$recommendedWorksDataSourceHash() =>
    r'44af69a849f4c7863f2553ec583d2d0dcecb0b2e';
