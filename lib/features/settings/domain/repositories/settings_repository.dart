import 'package:flutter/material.dart';

abstract class SettingsRepository {
  Future<ThemeMode> getThemeMode();
  Future<void> setThemeMode(ThemeMode themeMode);
  Future<bool> getNotificationEnabled();
  Future<void> setNotificationEnabled(bool isEnabled);
  Future<bool> getHasShownNotificationDialog();
  Future<void> setHasShownNotificationDialog(bool hasShown);
}
