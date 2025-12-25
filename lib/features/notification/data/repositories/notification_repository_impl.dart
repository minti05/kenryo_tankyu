import 'package:kenryo_tankyu/features/notification/data/datasources/notification_local_data_source.dart';
import 'package:kenryo_tankyu/features/notification/data/datasources/notification_remote_data_source.dart';
import 'package:kenryo_tankyu/features/notification/domain/models/notification_content.dart';
import 'package:kenryo_tankyu/features/notification/domain/repositories/notification_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_repository_impl.g.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  NotificationRepositoryImpl(this._localDataSource, this._remoteDataSource);

  final NotificationLocalDataSource _localDataSource;
  final NotificationRemoteDataSource _remoteDataSource;

  @override
  Future<List<NotificationContent>> fetchNotifications() async {
    final localData = await _localDataSource.read(0);
    if (localData != null && localData.isNotEmpty) {
      return localData;
    } else {
      return _remoteDataSource.fetchLatestNotifications();
    }
  }

  @override
  Future<void> markAsRead(int id) async {
    await _localDataSource.markAsRead(id);
  }
}

@riverpod
NotificationRepository notificationRepository(Ref ref) {
  final local = ref.watch(notificationLocalDataSourceProvider);
  final remote = ref.watch(notificationRemoteDataSourceProvider);
  return NotificationRepositoryImpl(local, remote);
}
