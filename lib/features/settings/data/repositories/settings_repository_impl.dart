import 'package:flutter/material.dart';
import 'package:kenryo_tankyu/features/settings/data/datasources/datasources.dart';
import 'package:kenryo_tankyu/features/settings/domain/repositories/settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_repository_impl.g.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._dataSource);

  final SettingsDataSource _dataSource;

  @override
  Future<ThemeMode> getThemeMode() async {
    final themeCode = await _dataSource.getThemeCode();
    final effectiveThemeCode = themeCode ?? 'system';
    return ThemeMode.values.firstWhere(
      (e) => e.toString() == 'ThemeMode.$effectiveThemeCode',
      orElse: () => ThemeMode.system,
    );
  }

  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    await _dataSource.setThemeCode(themeMode.toString().split('.').last);
  }

  @override
  Future<bool> getNotificationEnabled() async {
    final enabled = await _dataSource.getNotificationEnabled();
    return enabled ?? false;
  }

  @override
  Future<void> setNotificationEnabled(bool isEnabled) async {
    await _dataSource.setNotificationEnabled(isEnabled);
  }

  @override
  Future<bool> getHasShownNotificationDialog() async {
    final hasShown = await _dataSource.getHasShownNotificationDialog();
    return hasShown ?? false;
  }

  @override
  Future<void> setHasShownNotificationDialog(bool hasShown) async {
    await _dataSource.setHasShownNotificationDialog(hasShown);
  }
}

@riverpod
SettingsRepository settingsRepository(Ref ref) {
  final dataSource = ref.watch(settingsDataSourceProvider);
  return SettingsRepositoryImpl(dataSource);
}
