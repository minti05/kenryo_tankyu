import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:kenryo_tankyu/features/notification/domain/models/notification_content.dart';

class NotificationNotifier
    extends Notifier<AsyncValue<List<NotificationContent>>> {
  @override
  AsyncValue<List<NotificationContent>> build() {
    _fetchNotifications();
    return const AsyncLoading();
  }

  Future<void> _fetchNotifications() async {
    state = const AsyncLoading();
    try {
      final repository = ref.read(notificationRepositoryProvider);
      final data = await repository.fetchNotifications();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> markAsRead(int id) async {
    // 成功時のみ状態を更新する
    try {
      final repository = ref.read(notificationRepositoryProvider);
      await repository.markAsRead(id);

      state.whenData((notifications) {
        state = AsyncValue.data(notifications.map((notification) {
          // Note: id in model is String but repository might use int for Local DB.
          // Checking notification_content.dart shows id is String.
          // But repository markAsRead takes int id?
          // Wait, NotificationRepository.markAsRead takes int id.
          // NotificationContent.id is String.
          // This seems like a type mismatch in existing code.
          // For now, I'll keep it as is or try to match them.
          if (notification.id == id.toString()) {
            return notification.copyWith(isRead: true);
          }
          return notification;
        }).toList());
      });
    } catch (e) {
      // markAsRead のエラーは画面全体を止めるほどではないかもしれないが、
      // 必要があれば各UIでエラーハンドリングする
      rethrow;
    }
  }

  Future<void> refresh() async {
    await _fetchNotifications();
  }
}

final notificationProvider = NotifierProvider<NotificationNotifier,
    AsyncValue<List<NotificationContent>>>(
  NotificationNotifier.new,
);
