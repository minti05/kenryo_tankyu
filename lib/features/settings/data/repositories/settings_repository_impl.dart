import 'package:flutter/material.dart';
import 'package:kenryo_tankyu/features/settings/domain/repositories/repositories.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;
  static const _themeKey = 'themeModeCode';

  @override
  Future<ThemeMode> getThemeMode() async {
    final themeCode = _prefs.getString(_themeKey) ?? 'system';
    return ThemeMode.values.firstWhere(
      (e) => e.toString() == 'ThemeMode.$themeCode',
      orElse: () => ThemeMode.system,
    );
  }

  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    await _prefs.setString(_themeKey, themeMode.toString().split('.').last);
  }

  static const _notificationKey = 'isNotification';

  @override
  Future<bool> getNotificationEnabled() async {
    return _prefs.getBool(_notificationKey) ?? false;
  }

  @override
  Future<void> setNotificationEnabled(bool isEnabled) async {
    await _prefs.setBool(_notificationKey, isEnabled);
  }
}
