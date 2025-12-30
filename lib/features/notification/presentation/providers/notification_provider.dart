import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:kenryo_tankyu/features/notification/domain/models/notification_content.dart';
import 'package:kenryo_tankyu/core/connectivity/connectivity_provider.dart';
import 'package:kenryo_tankyu/core/error/failures.dart';

class NotificationNotifier
    extends Notifier<AsyncValue<List<NotificationContent>>> {
  @override
  AsyncValue<List<NotificationContent>> build() {
    // 接続状態を監視し、回復時に再取得
    ref.listen(isConnectedProvider, (previous, next) {
      if (previous == false && next == true) {
        refresh();
      }
    });

    _fetchNotifications();
    return const AsyncLoading();
  }

  Future<void> _fetchNotifications() async {
    final isConnected = ref.read(isConnectedProvider);
    if (!isConnected) {
      state = AsyncValue.error(const NetworkFailure(), StackTrace.current);
      return;
    }

    state = const AsyncLoading();
    try {
      final repository = ref.read(notificationRepositoryProvider);
      final data = await repository.fetchNotifications();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<bool> markAsRead(int id) async {
    try {
      final repository = ref.read(notificationRepositoryProvider);
      await repository.markAsRead(id);

      state.whenData((notifications) {
        state = AsyncValue.data(notifications.map((notification) {
          if (notification.id == id.toString()) {
            return notification.copyWith(isRead: true);
          }
          return notification;
        }).toList());
      });
      return true;
    } catch (e) {
      // エラーログ出力などを行い、上位には成功/失敗を返すのみにする
      return false;
    }
  }

  Future<bool> markAsReadAll() async {
    try {
      // TODO: リポジトリに指定がない場合は全件更新を検討
      // 現状は state にあるものをすべて true にする
      state.whenData((notifications) {
        state = AsyncValue.data(
            notifications.map((n) => n.copyWith(isRead: true)).toList());
      });
      return true;
    } catch (e) {
      return false;
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
