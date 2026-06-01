// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_notification_ids_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReadNotificationIds)
const readNotificationIdsProvider = ReadNotificationIdsProvider._();

final class ReadNotificationIdsProvider
    extends $NotifierProvider<ReadNotificationIds, Set<String>> {
  const ReadNotificationIdsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'readNotificationIdsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$readNotificationIdsHash();

  @$internal
  @override
  ReadNotificationIds create() => ReadNotificationIds();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$readNotificationIdsHash() =>
    r'08da3d4aff6c05bfe5a9b14daa754b00e5a9b127';

abstract class _$ReadNotificationIds extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Set<String>, Set<String>>, Set<String>, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
