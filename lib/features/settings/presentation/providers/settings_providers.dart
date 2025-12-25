import 'package:flutter/material.dart';
import 'package:kenryo_tankyu/features/settings/data/repositories/repositories.dart';
import 'package:kenryo_tankyu/features/settings/domain/repositories/repositories.dart';
import 'package:kenryo_tankyu/features/settings/domain/usecases/usecases.dart';
import 'package:kenryo_tankyu/core/providers/shared_preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_providers.g.dart';

@riverpod
SettingsRepository settingsRepository(Ref ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return SettingsRepositoryImpl(sharedPreferences);
}

// Theme
@riverpod
GetThemeModeUsecase getThemeModeUsecase(Ref ref) {
  return GetThemeModeUsecase(ref.watch(settingsRepositoryProvider));
}

@riverpod
SetThemeModeUsecase setThemeModeUsecase(Ref ref) {
  return SetThemeModeUsecase(ref.watch(settingsRepositoryProvider));
}

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  Future<ThemeMode> build() async {
    final getThemeMode = ref.watch(getThemeModeUsecaseProvider);
    return getThemeMode();
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    state = const AsyncValue.loading();
    final setUseCase = ref.read(setThemeModeUsecaseProvider);
    state = await AsyncValue.guard(() async {
      await setUseCase(themeMode);
      return themeMode;
    });
  }
}

// Notification
@riverpod
GetNotificationEnabledUsecase getNotificationEnabledUsecase(Ref ref) {
  return GetNotificationEnabledUsecase(ref.watch(settingsRepositoryProvider));
}

@riverpod
SetNotificationEnabledUsecase setNotificationEnabledUsecase(Ref ref) {
  return SetNotificationEnabledUsecase(ref.watch(settingsRepositoryProvider));
}

@riverpod
class NotificationSettingNotifier extends _$NotificationSettingNotifier {
  @override
  Future<bool> build() async {
    final getNotificationEnabled = ref.watch(getNotificationEnabledUsecaseProvider);
    return getNotificationEnabled();
  }

  Future<void> toggle() async {
    final current = state.value ?? false;
    final next = !current;
    state = const AsyncValue.loading();
    final setUseCase = ref.read(setNotificationEnabledUsecaseProvider);
    state = await AsyncValue.guard(() async {
      await setUseCase(next);
      return next;
    });
  }
}
