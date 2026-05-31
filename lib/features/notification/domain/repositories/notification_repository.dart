import 'package:kenryo_tankyu/features/notification/domain/models/notification_content.dart';

abstract class NotificationRepository {
  Future<List<NotificationContent>> fetchNotifications();
}
