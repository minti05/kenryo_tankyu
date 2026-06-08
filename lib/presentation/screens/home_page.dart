import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import "package:kenryo_tankyu/core/constants/app_unique_value.dart";
import 'package:kenryo_tankyu/features/search/presentation/widgets/result_preview_content.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/algolia_provider.dart';
import 'package:kenryo_tankyu/features/auth/presentation/providers/auth_provider.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/widgets/user_stats_section.dart';
import 'package:kenryo_tankyu/presentation/widget/error_view.dart';
import 'package:kenryo_tankyu/presentation/widget/startup_dialogs.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await checkStartupDialogs(context, ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileName = developer_mode
        ? 'ゲスト'
        : ref.watch(authStateChangesProvider).asData?.value?.displayName ??
            'ゲスト';
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
            const UserStatsSection(),
            const SizedBox(height: 16),
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
                    error: (error, stackTrace) => CommonErrorView(
                          error: error,
                          onRetry: () {
                            ref.read(forceRefreshProvider.notifier).state =
                                true;
                            ref.invalidate(randomAlgoliaSearchProvider);
                          },
                        ),
                    data: (data) {
                      return Column(
                        children: [
                          Card(
                            child: ResultPreviewContent(
                              searched: data[0],
                              mode: ResultPreviewMode.search,
                            ),
                          ),
                          Card(
                            child: ResultPreviewContent(
                              searched: data[1],
                              mode: ResultPreviewMode.search,
                            ),
                          ),
                        ],
                      );
                    });
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
