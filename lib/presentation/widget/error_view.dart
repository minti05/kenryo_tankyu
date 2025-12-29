import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/core/error/failures.dart';
import 'package:kenryo_tankyu/core/connectivity/connectivity_provider.dart';

/// ページやリスト内で使用する共通のエラー表示ウィジェット
class CommonErrorView extends ConsumerWidget {
  final Object error;
  final VoidCallback? onRetry;

  const CommonErrorView({
    super.key,
    required this.error,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isConnected = ref.watch(isConnectedProvider);

    String message = 'エラーが発生しました。';
    IconData icon = Icons.error_outline;

    if (!isConnected) {
      message = 'インターネットに接続されていません。';
      icon = Icons.wifi_off;
    } else if (error is Failure) {
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
            Icon(
              icon,
              color: isConnected ? Colors.red : Colors.grey,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (!isConnected) ...[
              const SizedBox(height: 8),
              const Text(
                '再接続を待機しています...',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
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
