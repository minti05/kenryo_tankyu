import 'package:flutter/material.dart';
import 'package:kenryo_tankyu/features/settings/domain/repositories/settings_repository.dart';

class GetThemeModeUsecase {
  GetThemeModeUsecase(this._repository);
  final SettingsRepository _repository;

  Future<ThemeMode> call() async {
    return _repository.getThemeMode();
  }
}
