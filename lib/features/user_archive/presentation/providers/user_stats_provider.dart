import 'package:kenryo_tankyu/features/auth/presentation/providers/auth_provider.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/user_stats_data_source.dart';
import 'package:kenryo_tankyu/features/user_archive/domain/models/user_stats.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_stats_provider.g.dart';

@Riverpod(keepAlive: true)
class UserStatsNotifier extends _$UserStatsNotifier {
  @override
  Future<UserStats> build() async {
    final user = await ref.watch(authStateChangesProvider.future);
    if (user == null || !user.emailVerified) {
      return const UserStats(
        todayViews: 0,
        weekViews: 0,
        totalViews: 0,
        streakDays: 0,
      );
    }
    final dataSource = ref.read(userStatsDataSourceProvider);
    return dataSource.getStats(user.uid);
  }

  Future<void> refresh() async {
    final user = ref.read(authStateChangesProvider).asData?.value;
    if (user == null || !user.emailVerified) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final dataSource = ref.read(userStatsDataSourceProvider);
      return dataSource.refreshStats(user.uid);
    });
  }
}
