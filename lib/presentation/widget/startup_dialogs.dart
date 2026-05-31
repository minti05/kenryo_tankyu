import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/core/providers/shared_preferences_provider.dart';
import 'package:kenryo_tankyu/features/notification/presentation/widgets/notification_permission_dialog.dart';
import 'package:kenryo_tankyu/features/settings/presentation/providers/settings_providers.dart';

/// ホーム画面の初回表示時に必要なダイアログをまとめて制御する。
///
/// 表示順:
///   1. SQLite→Supabase移行ダイアログ（旧ユーザーのみ）
///   2. 通知許可ダイアログ（未表示ユーザーのみ）
Future<void> checkStartupDialogs(BuildContext context, WidgetRef ref) async {
  await _checkMigrationDialog(context, ref);
  if (!context.mounted) return;
  await _checkNotificationDialog(context, ref);
}

Future<void> _checkMigrationDialog(
    BuildContext context, WidgetRef ref) async {
  final prefs = ref.read(sharedPreferencesProvider);
  if (prefs.getBool('supabase_migration_dialog_pending_v1') != true) return;
  await prefs.remove('supabase_migration_dialog_pending_v1');
  if (!context.mounted) return;
  await showDialog<void>(
    context: context,
    builder: (_) => const _DataSyncMigrationDialog(),
  );
}

Future<void> _checkNotificationDialog(
    BuildContext context, WidgetRef ref) async {
  final hasShown = await ref.read(hasShownNotificationDialogProvider.future);
  if (!hasShown && context.mounted) {
    await showNotificationPermissionDialog(context);
  }
}

class _DataSyncMigrationDialog extends StatelessWidget {
  const _DataSyncMigrationDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('データ同期機能を追加しました'),
      content: const Text(
        '閲覧履歴・お気に入り・検索履歴が端末間で同期されるようになりました。\n\n'
        'これに伴い、アップデート前の履歴・お気に入りデータはリセットされています。',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
