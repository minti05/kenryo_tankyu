import 'package:flutter/material.dart';
import 'package:kenryo_tankyu/features/settings/data/repositories/repositories.dart';
import 'package:kenryo_tankyu/features/settings/domain/repositories/repositories.dart';
import 'package:kenryo_tankyu/features/settings/domain/usecases/usecases.dart';
import 'package:kenryo_tankyu/core/providers/shared_preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'theme_providers.g.dart';



@riverpod
SettingsRepository settingsRepository(Ref ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return SettingsRepositoryImpl(sharedPreferences);
}

@riverpod
GetThemeModeUsecase getThemeModeUsecase(Ref ref) {
  return GetThemeModeUsecase(ref.watch(settingsRepositoryProvider));
}

@riverpod
SetThemeModeUsecase setThemeModeUsecase(ref) {
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
