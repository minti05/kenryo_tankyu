// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommended_works_local_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(recommendedWorksLocalDataSource)
const recommendedWorksLocalDataSourceProvider =
    RecommendedWorksLocalDataSourceProvider._();

final class RecommendedWorksLocalDataSourceProvider extends $FunctionalProvider<
        RecommendedWorksLocalDataSource,
        RecommendedWorksLocalDataSource,
        RecommendedWorksLocalDataSource>
    with $Provider<RecommendedWorksLocalDataSource> {
  const RecommendedWorksLocalDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'recommendedWorksLocalDataSourceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$recommendedWorksLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<RecommendedWorksLocalDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RecommendedWorksLocalDataSource create(Ref ref) {
    return recommendedWorksLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecommendedWorksLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<RecommendedWorksLocalDataSource>(value),
    );
  }
}

String _$recommendedWorksLocalDataSourceHash() =>
    r'0bc8d7852f6fd29c0668971507c34975a15f351c';
