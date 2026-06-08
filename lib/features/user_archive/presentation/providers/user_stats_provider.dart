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
    state = const AsyncLoading<UserStats>();
    state = await AsyncValue.guard(() async {
      final dataSource = ref.read(userStatsDataSourceProvider);
      return dataSource.refreshStats(user.uid);
    });
  }

  /// 新規閲覧時にインメモリカウントをインクリメントする。
  /// Supabase への再フェッチなしで即時反映させる。
  void incrementViewCount() {
    final current = state.asData?.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(
      todayViews: current.todayViews + 1,
      weekViews: current.weekViews + 1,
      totalViews: current.totalViews + 1,
    ));
    // キャッシュも更新して次回起動時に整合性を保つ
    ref.read(userStatsDataSourceProvider).updateCachedCounts(
          todayViews: current.todayViews + 1,
          weekViews: current.weekViews + 1,
          totalViews: current.totalViews + 1,
        );
  }
}
