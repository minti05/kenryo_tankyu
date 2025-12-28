// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_archive_remote_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userArchiveRemoteDataSource)
const userArchiveRemoteDataSourceProvider =
    UserArchiveRemoteDataSourceProvider._();

final class UserArchiveRemoteDataSourceProvider extends $FunctionalProvider<
    UserArchiveRemoteDataSource,
    UserArchiveRemoteDataSource,
    UserArchiveRemoteDataSource> with $Provider<UserArchiveRemoteDataSource> {
  const UserArchiveRemoteDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userArchiveRemoteDataSourceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userArchiveRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<UserArchiveRemoteDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserArchiveRemoteDataSource create(Ref ref) {
    return userArchiveRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserArchiveRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserArchiveRemoteDataSource>(value),
    );
  }
}

String _$userArchiveRemoteDataSourceHash() =>
    r'447d701bb5d3849f790427110fd1e5ca9b839f6f';
