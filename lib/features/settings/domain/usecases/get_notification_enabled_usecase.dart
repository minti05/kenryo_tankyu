import 'package:kenryo_tankyu/features/settings/domain/repositories/settings_repository.dart';

class GetNotificationEnabledUsecase {
  final SettingsRepository _repository;

  GetNotificationEnabledUsecase(this._repository);

  Future<bool> call() async {
    return _repository.getNotificationEnabled();
  }
}
