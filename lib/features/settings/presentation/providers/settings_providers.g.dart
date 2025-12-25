// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(settingsRepository)
const settingsRepositoryProvider = SettingsRepositoryProvider._();

final class SettingsRepositoryProvider extends $FunctionalProvider<
    SettingsRepository,
    SettingsRepository,
    SettingsRepository> with $Provider<SettingsRepository> {
  const SettingsRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'settingsRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$settingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<SettingsRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SettingsRepository create(Ref ref) {
    return settingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsRepository>(value),
    );
  }
}

String _$settingsRepositoryHash() =>
    r'2e19c3184f4e88652b05db463cba9763b326e908';

@ProviderFor(getThemeModeUsecase)
const getThemeModeUsecaseProvider = GetThemeModeUsecaseProvider._();

final class GetThemeModeUsecaseProvider extends $FunctionalProvider<
    GetThemeModeUsecase,
    GetThemeModeUsecase,
    GetThemeModeUsecase> with $Provider<GetThemeModeUsecase> {
  const GetThemeModeUsecaseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'getThemeModeUsecaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getThemeModeUsecaseHash();

  @$internal
  @override
  $ProviderElement<GetThemeModeUsecase> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetThemeModeUsecase create(Ref ref) {
    return getThemeModeUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetThemeModeUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetThemeModeUsecase>(value),
    );
  }
}

String _$getThemeModeUsecaseHash() =>
    r'2ec13e381b5b6e1a4e5809b6a999464649f88d00';

@ProviderFor(setThemeModeUsecase)
const setThemeModeUsecaseProvider = SetThemeModeUsecaseProvider._();

final class SetThemeModeUsecaseProvider extends $FunctionalProvider<
    SetThemeModeUsecase,
    SetThemeModeUsecase,
    SetThemeModeUsecase> with $Provider<SetThemeModeUsecase> {
  const SetThemeModeUsecaseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'setThemeModeUsecaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$setThemeModeUsecaseHash();

  @$internal
  @override
  $ProviderElement<SetThemeModeUsecase> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SetThemeModeUsecase create(Ref ref) {
    return setThemeModeUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SetThemeModeUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SetThemeModeUsecase>(value),
    );
  }
}

String _$setThemeModeUsecaseHash() =>
    r'd3b06838eee6cce2ecaaf4767c8ef3d12b3b78ba';

@ProviderFor(ThemeModeNotifier)
const themeModeProvider = ThemeModeNotifierProvider._();

final class ThemeModeNotifierProvider
    extends $AsyncNotifierProvider<ThemeModeNotifier, ThemeMode> {
  const ThemeModeNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'themeModeProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$themeModeNotifierHash();

  @$internal
  @override
  ThemeModeNotifier create() => ThemeModeNotifier();
}

String _$themeModeNotifierHash() => r'6cd8389fc3505090091520fa0cf105af0f088463';

abstract class _$ThemeModeNotifier extends $AsyncNotifier<ThemeMode> {
  FutureOr<ThemeMode> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<ThemeMode>, ThemeMode>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<ThemeMode>, ThemeMode>,
        AsyncValue<ThemeMode>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(getNotificationEnabledUsecase)
const getNotificationEnabledUsecaseProvider =
    GetNotificationEnabledUsecaseProvider._();

final class GetNotificationEnabledUsecaseProvider extends $FunctionalProvider<
        GetNotificationEnabledUsecase,
        GetNotificationEnabledUsecase,
        GetNotificationEnabledUsecase>
    with $Provider<GetNotificationEnabledUsecase> {
  const GetNotificationEnabledUsecaseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'getNotificationEnabledUsecaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getNotificationEnabledUsecaseHash();

  @$internal
  @override
  $ProviderElement<GetNotificationEnabledUsecase> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetNotificationEnabledUsecase create(Ref ref) {
    return getNotificationEnabledUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetNotificationEnabledUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<GetNotificationEnabledUsecase>(value),
    );
  }
}

String _$getNotificationEnabledUsecaseHash() =>
    r'36483a97347b1a72ed41e21a047232c7fc199fb3';

@ProviderFor(setNotificationEnabledUsecase)
const setNotificationEnabledUsecaseProvider =
    SetNotificationEnabledUsecaseProvider._();

final class SetNotificationEnabledUsecaseProvider extends $FunctionalProvider<
        SetNotificationEnabledUsecase,
        SetNotificationEnabledUsecase,
        SetNotificationEnabledUsecase>
    with $Provider<SetNotificationEnabledUsecase> {
  const SetNotificationEnabledUsecaseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'setNotificationEnabledUsecaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$setNotificationEnabledUsecaseHash();

  @$internal
  @override
  $ProviderElement<SetNotificationEnabledUsecase> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SetNotificationEnabledUsecase create(Ref ref) {
    return setNotificationEnabledUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SetNotificationEnabledUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<SetNotificationEnabledUsecase>(value),
    );
  }
}

String _$setNotificationEnabledUsecaseHash() =>
    r'31cca43a9fa3eb518fcfb9bc827f53a5938180ad';

@ProviderFor(NotificationSettingNotifier)
const notificationSettingProvider = NotificationSettingNotifierProvider._();

final class NotificationSettingNotifierProvider
    extends $AsyncNotifierProvider<NotificationSettingNotifier, bool> {
  const NotificationSettingNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'notificationSettingProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$notificationSettingNotifierHash();

  @$internal
  @override
  NotificationSettingNotifier create() => NotificationSettingNotifier();
}

String _$notificationSettingNotifierHash() =>
    r'b1b9d027be793bd3799091b0ff0062d39cb0a92c';

abstract class _$NotificationSettingNotifier extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<bool>, bool>,
        AsyncValue<bool>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
