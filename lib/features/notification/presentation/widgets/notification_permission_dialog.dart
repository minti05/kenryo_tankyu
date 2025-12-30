import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/features/settings/presentation/providers/settings_providers.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationPermissionDialog extends ConsumerWidget {
  const NotificationPermissionDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('通知をオンにしませんか？'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('通知を許可すると、以下の情報を受け取ることができます。'),
          SizedBox(height: 12),
          Text('・新しい研究作品の公開'),
          Text('・お知らせやアップデート情報'),
          Text('・重要なお知らせ'),
          SizedBox(height: 12),
          Text('※設定画面からいつでも変更できます。'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            // 二度と表示しない
            await ref
                .read(settingsProvider.notifier)
                .setHasShownNotificationDialog(true);
            await ref.read(settingsProvider.notifier).setNotification(false);
            if (context.mounted) Navigator.of(context).pop();
          },
          child: const Text('二度と表示しない', style: TextStyle(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () {
            // 今はしない
            Navigator.of(context).pop();
          },
          child: const Text('今はしない'),
        ),
        ElevatedButton(
          onPressed: () async {
            // 許可する
            await ref
                .read(settingsProvider.notifier)
                .setHasShownNotificationDialog(true);

            // OSの権限リクエスト
            final status = await Permission.notification.request();

            if (status.isGranted) {
              await ref.read(settingsProvider.notifier).setNotification(true);
            } else {
              await ref.read(settingsProvider.notifier).setNotification(false);
            }

            if (context.mounted) Navigator.of(context).pop();
          },
          child: const Text('許可する'),
        ),
      ],
    );
  }
}

Future<void> showNotificationPermissionDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const NotificationPermissionDialog(),
  );
}
