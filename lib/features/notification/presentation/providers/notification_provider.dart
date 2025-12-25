import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:kenryo_tankyu/features/notification/domain/models/notification_content.dart';

class NotificationNotifier extends Notifier<List<NotificationContent>> {
  @override
  List<NotificationContent> build() {
    _fetchNotifications();
    return <NotificationContent>[];
  }

  Future<void> _fetchNotifications() async {
    final repository = ref.read(notificationRepositoryProvider);
    final data = await repository.fetchNotifications();
    state = data;
  }

  Future<void> markAsRead(int id) async {
    final repository = ref.read(notificationRepositoryProvider);
    await repository.markAsRead(id);
    state = state.map((notification) {
      if (notification.id == id) {
        return notification.copyWith(isRead: true);
      }
      return notification;
    }).toList();
  }
}

final notificationProvider =
    NotifierProvider<NotificationNotifier, List<NotificationContent>>(
  NotificationNotifier.new,
);
