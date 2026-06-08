// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_stats_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userStatsDataSource)
final userStatsDataSourceProvider = UserStatsDataSourceProvider._();

final class UserStatsDataSourceProvider extends $FunctionalProvider<
    UserStatsDataSource,
    UserStatsDataSource,
    UserStatsDataSource> with $Provider<UserStatsDataSource> {
  UserStatsDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userStatsDataSourceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userStatsDataSourceHash();

  @$internal
  @override
  $ProviderElement<UserStatsDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserStatsDataSource create(Ref ref) {
    return userStatsDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserStatsDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserStatsDataSource>(value),
    );
  }
}

String _$userStatsDataSourceHash() =>
    r'd888b00c3dbe23892cfb2bbe81568cd39b85c17f';
