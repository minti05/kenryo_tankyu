import 'package:flutter/material.dart';
import 'package:kenryo_tankyu/core/error/failures.dart';

/// ページやリスト内で使用する共通のエラー表示ウィジェット
class CommonErrorView extends StatelessWidget {
  final Object error;
  final VoidCallback? onRetry;

  const CommonErrorView({
    super.key,
    required this.error,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    String message = 'エラーが発生しました。';

    if (error is Failure) {
      message = (error as Failure).message;
    } else {
      message = error.toString();
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('再試行'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
