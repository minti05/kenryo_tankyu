import 'dart:async';

import 'package:kenryo_tankyu/core/providers/supabase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'read_notification_ids_provider.g.dart';

@Riverpod(keepAlive: true)
class ReadNotificationIds extends _$ReadNotificationIds {
  @override
  Set<String> build() => {};

  Future<void> initialize(String userId) async {
    final supabase = ref.read(supabaseClientProvider);
    try {
      final rows = await supabase
          .from('notification_reads')
          .select('notification_id')
          .eq('user_id', userId);
      state = rows.map<String>((r) => r['notification_id'] as String).toSet();
    } catch (_) {
      state = {};
    }
  }

  Future<void> markAsRead(String userId, String notificationId) async {
    state = {...state, notificationId};
    unawaited(
      ref.read(supabaseClientProvider).from('notification_reads').upsert(
        {'user_id': userId, 'notification_id': notificationId},
      ),
    );
  }

  Future<void> markAllAsRead(
    String userId,
    Set<String> notificationIds,
  ) async {
    state = {...state, ...notificationIds};
    if (notificationIds.isEmpty) return;
    unawaited(
      ref.read(supabaseClientProvider).from('notification_reads').upsert(
            notificationIds
                .map((id) => {'user_id': userId, 'notification_id': id})
                .toList(),
          ),
    );
  }
}
