import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/features/notification/presentation/providers/notification_provider.dart';
import 'package:kenryo_tankyu/features/notification/presentation/widgets/notification_list.dart';

import 'package:kenryo_tankyu/presentation/widget/error_view.dart';

class NotificationPage extends ConsumerWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('お知らせ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.mark_email_read),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('全て既読にしますか？'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('キャンセル'),
                        ),
                        TextButton(
                          onPressed: () {
                            // TODO: 全て既読にする処理を notifier に追加する
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
      body: notificationsAsync.when(
        data: (notifications) => RefreshIndicator(
          onRefresh: () => ref.read(notificationProvider.notifier).refresh(),
          child: NotificationList(notifications: notifications),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => CommonErrorView(
          error: error,
          onRetry: () => ref.read(notificationProvider.notifier).refresh(),
        ),
      ),
    );
  }
}
