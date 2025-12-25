// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_local_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationLocalDataSource)
const notificationLocalDataSourceProvider =
    NotificationLocalDataSourceProvider._();

final class NotificationLocalDataSourceProvider extends $FunctionalProvider<
    NotificationLocalDataSource,
    NotificationLocalDataSource,
    NotificationLocalDataSource> with $Provider<NotificationLocalDataSource> {
  const NotificationLocalDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'notificationLocalDataSourceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$notificationLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<NotificationLocalDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NotificationLocalDataSource create(Ref ref) {
    return notificationLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationLocalDataSource>(value),
    );
  }
}

String _$notificationLocalDataSourceHash() =>
    r'f71b0849f8778c756be7eeeb71a3109b1e262338';
