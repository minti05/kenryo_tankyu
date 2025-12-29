import 'package:kenryo_tankyu/core/providers/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'datasources.g.dart';

abstract class SettingsDataSource {
  String? getThemeCode();
  Future<void> setThemeCode(String themeCode);
  bool? getNotificationEnabled();
  Future<void> setNotificationEnabled(bool isEnabled);
}

class SettingsDataSourceImpl implements SettingsDataSource {
  SettingsDataSourceImpl(this._prefs);
  final SharedPreferences _prefs;

  static const _themeKey = 'themeModeCode';
  static const _notificationKey = 'isNotification';

  @override
  String? getThemeCode() {
    return _prefs.getString(_themeKey);
  }

  @override
  Future<void> setThemeCode(String themeCode) async {
    await _prefs.setString(_themeKey, themeCode);
  }

  @override
  bool? getNotificationEnabled() {
    return _prefs.getBool(_notificationKey);
  }

  @override
  Future<void> setNotificationEnabled(bool isEnabled) async {
    await _prefs.setBool(_notificationKey, isEnabled);
  }
}

@riverpod
SettingsDataSource settingsDataSource(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SettingsDataSourceImpl(prefs);
}
