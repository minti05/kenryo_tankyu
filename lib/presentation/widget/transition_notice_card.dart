import 'package:flutter/material.dart';

/// 2026年11月末の旧アプリ終了と、新しいWebアプリへの移行案内。
class TransitionNoticeCard extends StatelessWidget {
  const TransitionNoticeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: colors.secondaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.auto_awesome_outlined,
                    size: 18, color: colors.onSecondaryContainer),
                const SizedBox(width: 8),
                Flexible(
                    child: Text('Coming soon…',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: colors.onSecondaryContainer,
                        ))),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '新しいWebアプリを\n準備しています',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.onSecondaryContainer,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'このアプリは2026年11月末でサービスを終了します。'
              '探究アーカイブは、新しいWebアプリとして生まれ変わります。'
              '公開時期やご利用方法は、学校の先生から改めてご案内します。',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSecondaryContainer,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: colors.onSecondaryContainer,
              ),
              onPressed: () => showDialog<void>(
                context: context,
                builder: (context) => const _TransitionNoticeDialog(),
              ),
              child: const Text('移行とサービス終了について'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransitionNoticeDialog extends StatelessWidget {
  const _TransitionNoticeDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('新しい探究アーカイブへの移行について'),
      content: const SingleChildScrollView(
        child: Text(
          'いつも探究アーカイブをご利用いただき、ありがとうございます。\n\n'
          '探究アーカイブは、新しいWebアプリとして生まれ変わります。現在、公開に向けて準備を進めています。\n\n'
          'このアプリは2026年11月末でサービスを終了します。'
          '終了までは、作品の検索・閲覧、お気に入り、履歴などの機能を引き続きご利用いただけます。\n\n'
          '新しいWebアプリの公開時期やご利用方法は、学校の先生から改めてご案内します。'
          '公開まで、もうしばらくお待ちください。\n\n'
          'お気に入り・履歴などのデータの取り扱いについても、詳細が決まり次第、学校の先生からご案内します。',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('閉じる'),
        ),
      ],
    );
  }
}
