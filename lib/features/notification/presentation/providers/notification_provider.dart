import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/features/auth/presentation/providers/auth_provider.dart';
import 'package:kenryo_tankyu/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:kenryo_tankyu/features/notification/domain/models/notification_content.dart';
import 'package:kenryo_tankyu/features/notification/presentation/providers/read_notification_ids_provider.dart';
import 'package:kenryo_tankyu/core/connectivity/connectivity_provider.dart';
import 'package:kenryo_tankyu/core/error/failures.dart';

class NotificationNotifier
    extends Notifier<AsyncValue<List<NotificationContent>>> {
  @override
  AsyncValue<List<NotificationContent>> build() {
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

  Future<void> markAsReadAll() async {
    final user = ref.read(authStateChangesProvider).asData?.value;
    if (user == null) return;

    final allIds = state.asData?.value.map((n) => n.id).toSet() ?? {};
    await ref
        .read(readNotificationIdsProvider.notifier)
        .markAllAsRead(user.uid, allIds);
  }

  Future<void> refresh() async {
    await _fetchNotifications();
  }
}

final notificationProvider = NotifierProvider<NotificationNotifier,
    AsyncValue<List<NotificationContent>>>(
  NotificationNotifier.new,
);
