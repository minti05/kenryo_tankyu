import 'package:kenryo_tankyu/features/notification/domain/models/notification_content.dart';

abstract class NotificationRepository {
  Future<List<NotificationContent>> fetchNotifications();
  Future<void> markAsRead(int id);
}
