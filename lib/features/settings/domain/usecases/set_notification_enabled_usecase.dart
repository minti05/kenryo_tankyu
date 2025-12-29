import 'package:kenryo_tankyu/features/settings/domain/repositories/repositories.dart';

class SetNotificationEnabledUsecase {
  final SettingsRepository _repository;

  SetNotificationEnabledUsecase(this._repository);

  Future<void> call(bool isEnabled) async {
    await _repository.setNotificationEnabled(isEnabled);
  }
}
