import 'package:flutter/material.dart';
import 'package:kenryo_tankyu/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_providers.g.dart';

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  @override
  Future<void> build() async {
    return;
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await ref.read(settingsRepositoryProvider).setThemeMode(mode);
    ref.invalidate(themeModeProvider);
  }

  Future<void> setNotification(bool enabled) async {
    await ref.read(settingsRepositoryProvider).setNotificationEnabled(enabled);
    ref.invalidate(notificationEnabledProvider);
  }

  Future<void> setHasShownNotificationDialog(bool hasShown) async {
    await ref
        .read(settingsRepositoryProvider)
        .setHasShownNotificationDialog(hasShown);
    ref.invalidate(hasShownNotificationDialogProvider);
  }
}

@riverpod
Future<ThemeMode> themeMode(Ref ref) {
  return ref.watch(settingsRepositoryProvider).getThemeMode();
}

@riverpod
Future<bool> notificationEnabled(Ref ref) {
  return ref.watch(settingsRepositoryProvider).getNotificationEnabled();
}

@riverpod
Future<bool> hasShownNotificationDialog(Ref ref) {
  return ref.watch(settingsRepositoryProvider).getHasShownNotificationDialog();
}
