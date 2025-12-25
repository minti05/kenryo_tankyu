//通知の内容をfirestoreから受け取るfuture provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/core/providers/firebase_providers.dart';
import 'package:kenryo_tankyu/features/notification/data/datasources/notification_db.dart';
import 'package:kenryo_tankyu/features/notification/domain/models/notification_content.dart';

class NotificationNotifier extends Notifier<List<NotificationContent>> {
  @override
  List<NotificationContent> build() {
    _fetchNotifications();
    return <NotificationContent>[];
  }

  Future<void> _fetchNotifications() async {
    final data = await NotificationDbController.read(0);
    if (data != null) {
      state = data;
    } else {

      final snapshot = await ref.read(firebaseFirestoreProvider)
          .collection('notifications')
          .orderBy('sendAt', descending: true)
          .limit(4)
          .get(const GetOptions(source: Source.server));
      state = snapshot.docs
          .map((doc) => NotificationContent.fromJson(doc.data()))
          .toList();
    }
  }

  Future<void> markAsRead(int id) async {
    await NotificationDbController.markAsRead(id);
    state = state.map((notification) {
      if (notification.id == id) {
        return notification.copyWith(isRead: true);
      }
      return notification;
    }).toList();
  }
}

final notificationProvider = NotifierProvider<NotificationNotifier, List<NotificationContent>>(
  NotificationNotifier.new,
);
