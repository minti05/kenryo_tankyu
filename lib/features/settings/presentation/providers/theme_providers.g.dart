// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_providers.dart';

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
    r'898f540b7e5166b6c5d377b1531971d2061cead0';

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
