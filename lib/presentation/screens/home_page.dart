import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import "package:kenryo_tankyu/core/constants/app_unique_value.dart";
import 'package:kenryo_tankyu/features/search/presentation/widgets/result_preview_content.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/algolia_provider.dart';
import 'package:kenryo_tankyu/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:kenryo_tankyu/presentation/widget/widget.dart';

import 'package:kenryo_tankyu/features/notification/presentation/widgets/notification_permission_dialog.dart';
import 'package:kenryo_tankyu/features/settings/presentation/providers/settings_providers.dart';

class HomePage extends ConsumerStatefulWidget {
  static HomePage builder(BuildContext context, GoRouterState state) =>
      const HomePage();
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    _checkNotificationPermission();
  }

  Future<void> _checkNotificationPermission() async {
    // 描画完了後にダイアログを表示
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final hasShown =
          await ref.read(hasShownNotificationDialogProvider.future);
      if (!hasShown) {
        if (mounted) {
          await showNotificationPermissionDialog(context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileName = developer_mode
        ? 'ゲスト'
        : ref.watch(authRepositoryProvider).currentUser?.displayName ?? 'ゲスト';
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('ようこそ、${profileName}さん'),
                IconButton(
                    onPressed: () => context.push('/settings'),
                    icon: const Icon(Icons.settings)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('今日のあなたに',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(
                    onPressed: () {
                      ref.read(forceRefreshProvider.notifier).state = true;
                      ref.invalidate(randomAlgoliaSearchProvider);
                    },
                    icon: const Icon(Icons.refresh)),
              ],
            ),
            Consumer(
              builder: (context, ref, child) {
                final asyncValue = ref.watch(randomAlgoliaSearchProvider);
                return asyncValue.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stackTrace) => Text('Error: $error'),
                    data: (data) {
                      return Column(
                        children: [
                          Card(
                            child: ResultPreviewContent(
                              searched: data[0],
                              forLibrary: false,
                            ),
                          ),
                          Card(
                            child: ResultPreviewContent(
                              searched: data[1],
                              forLibrary: false,
                            ),
                          ),
                        ],
                      );
                    });
              },
            ),
            const SizedBox(height: 16),
            const Text('コンテンツ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const ContentCarousel(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
