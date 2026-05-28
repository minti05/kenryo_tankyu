import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/core/connectivity/connectivity_provider.dart';
import 'package:kenryo_tankyu/core/error/failures.dart';

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
    final colorScheme = Theme.of(context).colorScheme;

    // エラー自体が NetworkFailure か、現在オフラインかで判定
    final isNetworkError = error is NetworkFailure || !isConnected;

    final String message;
    final IconData icon;

    if (isNetworkError) {
      message = 'インターネットに接続されていません。';
      icon = Icons.wifi_off_rounded;
    } else if (error is Failure) {
      message = (error as Failure).message;
      icon = Icons.error_outline_rounded;
    } else {
      message = error.toString();
      icon = Icons.error_outline_rounded;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isNetworkError ? colorScheme.outline : colorScheme.error,
              size: 52,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (isNetworkError && !isConnected) ...[
              const SizedBox(height: 8),
              Text(
                '接続を待機しています...',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.outline,
                    ),
              ),
            ],
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              FilledButton.icon(
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
