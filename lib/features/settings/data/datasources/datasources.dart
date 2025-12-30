import 'package:kenryo_tankyu/features/notification/data/datasources/notification_db.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'datasources.g.dart';

abstract class SettingsDataSource {
  Future<String?> getThemeCode();
  Future<void> setThemeCode(String themeCode);
  Future<bool?> getNotificationEnabled();
  Future<void> setNotificationEnabled(bool isEnabled);
  Future<bool?> getHasShownNotificationDialog();
  Future<void> setHasShownNotificationDialog(bool hasShown);
}

class SettingsDataSourceImpl implements SettingsDataSource {
  SettingsDataSourceImpl();

  static const _themeKey = 'themeModeCode';
  static const _notificationKey = 'isNotification';
  static const _hasShownNotificationDialogKey = 'hasShownNotificationDialog';

  @override
  Future<String?> getThemeCode() async {
    return await NotificationDbController.getSetting(_themeKey);
  }

  @override
  Future<void> setThemeCode(String themeCode) async {
    await NotificationDbController.upsertSetting(_themeKey, themeCode);
  }

  @override
  Future<bool?> getNotificationEnabled() async {
    final value = await NotificationDbController.getSetting(_notificationKey);
    if (value == null) return null;
    return value == 'true';
  }

  @override
  Future<void> setNotificationEnabled(bool isEnabled) async {
    await NotificationDbController.upsertSetting(
        _notificationKey, isEnabled.toString());
  }

  @override
  Future<bool?> getHasShownNotificationDialog() async {
    final value = await NotificationDbController.getSetting(
        _hasShownNotificationDialogKey);
    if (value == null) return null;
    return value == 'true';
  }

  @override
  Future<void> setHasShownNotificationDialog(bool hasShown) async {
    await NotificationDbController.upsertSetting(
        _hasShownNotificationDialogKey, hasShown.toString());
  }
}

@riverpod
SettingsDataSource settingsDataSource(Ref ref) {
  return SettingsDataSourceImpl();
}
