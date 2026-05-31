import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:kenryo_tankyu/core/providers/supabase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'read_notification_ids_provider.g.dart';

@Riverpod(keepAlive: true)
class ReadNotificationIds extends _$ReadNotificationIds {
  String? _activeUserId;

  @override
  Set<String> build() => {};

  Future<void> initialize(String userId) async {
    _activeUserId = userId;
    final supabase = ref.read(supabaseClientProvider);
    try {
      final rows = await supabase
          .from('notification_reads')
          .select('notification_id')
          .eq('user_id', userId);
      if (_activeUserId == userId) {
        state = rows.map<String>((r) => r['notification_id'] as String).toSet();
      }
    } catch (_) {
      if (_activeUserId == userId) {
        state = {};
      }
    }
  }

  Future<void> markAsRead(String userId, String notificationId) async {
    state = {...state, notificationId};
    unawaited(
      ref
          .read(supabaseClientProvider)
          .from('notification_reads')
          .upsert({'user_id': userId, 'notification_id': notificationId})
          .then((_) => null)
          .catchError((Object e) {
            debugPrint('notification_reads upsert error: $e');
          }),
    );
  }

  Future<void> markAllAsRead(
    String userId,
    Set<String> notificationIds,
  ) async {
    state = {...state, ...notificationIds};
    if (notificationIds.isEmpty) return;
    unawaited(
      ref
          .read(supabaseClientProvider)
          .from('notification_reads')
          .upsert(
            notificationIds
                .map((id) => {'user_id': userId, 'notification_id': id})
                .toList(),
          )
          .then((_) => null)
          .catchError((Object e) {
        debugPrint('notification_reads bulk upsert error: $e');
      }),
    );
  }

  Future<void> deleteAll(String userId) async {
    await ref
        .read(supabaseClientProvider)
        .from('notification_reads')
        .delete()
        .eq('user_id', userId);
  }
}
