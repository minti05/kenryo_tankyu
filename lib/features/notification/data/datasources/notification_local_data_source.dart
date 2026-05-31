import 'package:kenryo_tankyu/features/notification/data/datasources/notification_db.dart';
import 'package:kenryo_tankyu/features/notification/domain/models/notification_content.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_local_data_source.g.dart';

abstract class NotificationLocalDataSource {
  Future<List<NotificationContent>?> read(int paging);
}

class NotificationLocalDataSourceImpl implements NotificationLocalDataSource {
  @override
  Future<List<NotificationContent>?> read(int paging) {
    return NotificationDbController.read(paging);
  }
}

@riverpod
NotificationLocalDataSource notificationLocalDataSource(Ref ref) {
  return NotificationLocalDataSourceImpl();
}
