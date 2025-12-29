import 'package:flutter/material.dart';
import 'package:kenryo_tankyu/features/settings/domain/repositories/settings_repository.dart';

class SetThemeModeUsecase {
  SetThemeModeUsecase(this._repository);
  final SettingsRepository _repository;

  Future<void> call(ThemeMode themeMode) async {
    return _repository.setThemeMode(themeMode);
  }
}
