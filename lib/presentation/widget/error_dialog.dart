import 'package:flutter/material.dart';
import 'package:kenryo_tankyu/core/error/failures.dart';

/// 共通のエラーダイアログを表示する関数
void showErrorDialog(BuildContext context, Failure failure) {
  showDialog(
    context: context,
    builder: (context) => ErrorDialog(failure: failure),
  );
}

/// モダンなデザインのエラーダイアログ
class ErrorDialog extends StatelessWidget {
  final Failure failure;

  const ErrorDialog({super.key, required this.failure});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.errorContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                color: colorScheme.error,
                size: 40,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _getTitle(failure),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              failure.message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
            if (failure is ServerFailure &&
                (failure as ServerFailure).code != null) ...[
              const SizedBox(height: 8),
              Text(
                'Error Code: ${(failure as ServerFailure).code}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant.withAlpha(150),
                    ),
              ),
            ],
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  '閉じる',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTitle(Failure failure) {
    if (failure is NetworkFailure) return 'ネットワークエラー';
    if (failure is DatabaseFailure) return 'データベースエラー';
    if (failure is ServerFailure) return 'サーバーエラー';
    return 'エラーが発生しました';
  }
}
