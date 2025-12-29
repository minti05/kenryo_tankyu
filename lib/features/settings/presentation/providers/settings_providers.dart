
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
  }

  Future<void> setNotification(bool enabled) async {
    await ref.read(settingsRepositoryProvider).setNotificationEnabled(enabled);
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
