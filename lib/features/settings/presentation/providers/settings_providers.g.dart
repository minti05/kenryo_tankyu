// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SettingsNotifier)
const settingsProvider = SettingsNotifierProvider._();

final class SettingsNotifierProvider
    extends $AsyncNotifierProvider<SettingsNotifier, void> {
  const SettingsNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'settingsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$settingsNotifierHash();

  @$internal
  @override
  SettingsNotifier create() => SettingsNotifier();
}

String _$settingsNotifierHash() => r'ea2a489d77388c676633e3bcb5b08f49bffeb72e';

abstract class _$SettingsNotifier extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<void>, void>,
        AsyncValue<void>,
        Object?,
        Object?>;
    element.handleValue(ref, null);
  }
}

@ProviderFor(themeMode)
const themeModeProvider = ThemeModeProvider._();

final class ThemeModeProvider extends $FunctionalProvider<AsyncValue<ThemeMode>,
        ThemeMode, FutureOr<ThemeMode>>
    with $FutureModifier<ThemeMode>, $FutureProvider<ThemeMode> {
  const ThemeModeProvider._()
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
  String debugGetCreateSourceHash() => _$themeModeHash();

  @$internal
  @override
  $FutureProviderElement<ThemeMode> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<ThemeMode> create(Ref ref) {
    return themeMode(ref);
  }
}

String _$themeModeHash() => r'd4db32a6d830b04692f9b2d89de15f9f073c85f4';

@ProviderFor(notificationEnabled)
const notificationEnabledProvider = NotificationEnabledProvider._();

final class NotificationEnabledProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  const NotificationEnabledProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'notificationEnabledProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$notificationEnabledHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return notificationEnabled(ref);
  }
}

String _$notificationEnabledHash() =>
    r'15b79648d8f95a700baf52cad4729c3ff66db15a';

@ProviderFor(hasShownNotificationDialog)
const hasShownNotificationDialogProvider =
    HasShownNotificationDialogProvider._();

final class HasShownNotificationDialogProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  const HasShownNotificationDialogProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'hasShownNotificationDialogProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$hasShownNotificationDialogHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return hasShownNotificationDialog(ref);
  }
}

String _$hasShownNotificationDialogHash() =>
    r'09a8971a0d516e4cb15abe898b1214e8b5f5d212';
