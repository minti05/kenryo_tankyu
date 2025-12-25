import 'package:flutter/material.dart';
import 'package:kenryo_tankyu/features/settings/data/datasources/datasources.dart';
import 'package:kenryo_tankyu/features/settings/domain/repositories/repositories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_repository_impl.g.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._dataSource);

  final SettingsDataSource _dataSource;

  @override
  Future<ThemeMode> getThemeMode() async {
    final themeCode = _dataSource.getThemeCode() ?? 'system';
    return ThemeMode.values.firstWhere(
      (e) => e.toString() == 'ThemeMode.$themeCode',
      orElse: () => ThemeMode.system,
    );
  }

  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    await _dataSource.setThemeCode(themeMode.toString().split('.').last);
  }

  @override
  Future<bool> getNotificationEnabled() async {
    return _dataSource.getNotificationEnabled() ?? false;
  }

  @override
  Future<void> setNotificationEnabled(bool isEnabled) async {
    await _dataSource.setNotificationEnabled(isEnabled);
  }
}

@riverpod
SettingsRepository settingsRepository(Ref ref) {
  final dataSource = ref.watch(settingsDataSourceProvider);
  return SettingsRepositoryImpl(dataSource);
}
