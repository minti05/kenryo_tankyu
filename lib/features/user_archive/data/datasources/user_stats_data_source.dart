import 'package:kenryo_tankyu/core/providers/shared_preferences_provider.dart';
import 'package:kenryo_tankyu/core/providers/supabase_provider.dart';
import 'package:kenryo_tankyu/features/user_archive/domain/models/user_stats.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user_stats_data_source.g.dart';

@Riverpod(keepAlive: true)
UserStatsDataSource userStatsDataSource(Ref ref) {
  return UserStatsDataSource(
    ref.watch(supabaseClientProvider),
    ref.watch(sharedPreferencesProvider),
  );
}

class UserStatsDataSource {
  UserStatsDataSource(this._client, this._prefs);

  final SupabaseClient _client;
  final SharedPreferences _prefs;

  static const _keyFetchedAt = 'user_stats_fetched_at';
  static const _keyTodayViews = 'user_stats_today_views';
  static const _keyWeekViews = 'user_stats_week_views';
  static const _keyTotalViews = 'user_stats_total_views';
  static const _keyStreakDays = 'user_stats_streak_days';
  static const _keyLastOpenDate = 'user_stats_last_open_date';
  static const _cacheHours = 1;

  /// ストリークを更新してキャッシュから返す。
  /// 閲覧件数は1時間キャッシュし、期限切れなら Supabase から再取得する。
  Future<UserStats> getStats(String userId) async {
    final streak = _updateStreak();

    final fetchedAt = _prefs.getString(_keyFetchedAt);
    if (fetchedAt != null) {
      final last = DateTime.parse(fetchedAt);
      if (DateTime.now().difference(last) <
          const Duration(hours: _cacheHours)) {
        return _loadFromCache(streak);
      }
    }

    final stats = await _fetchFromSupabase(userId, streak);
    await _saveToCache(stats);
    return stats;
  }

  /// キャッシュを破棄して強制再取得する。
  Future<UserStats> refreshStats(String userId) async {
    await _prefs.remove(_keyFetchedAt);
    return getStats(userId);
  }

  /// インメモリのカウントアップに連動してキャッシュも更新する。
  void updateCachedCounts({
    required int todayViews,
    required int weekViews,
    required int totalViews,
  }) {
    _prefs.setInt(_keyTodayViews, todayViews);
    _prefs.setInt(_keyWeekViews, weekViews);
    _prefs.setInt(_keyTotalViews, totalViews);
  }

  int _updateStreak() {
    final today = _todayString();
    final lastOpen = _prefs.getString(_keyLastOpenDate);
    int streak = _prefs.getInt(_keyStreakDays) ?? 0;

    if (lastOpen == null) {
      streak = 1;
    } else if (lastOpen == today) {
      // 同日は変化なし
    } else if (lastOpen == _yesterdayString()) {
      streak += 1;
    } else {
      streak = 1;
    }

    _prefs.setString(_keyLastOpenDate, today);
    _prefs.setInt(_keyStreakDays, streak);
    return streak;
  }

  Future<UserStats> _fetchFromSupabase(String userId, int streak) async {
    // ローカル時間で「今日の開始」を求めてから UTC に変換（タイムゾーン対応）
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day).toUtc();
    final weekStart = todayStart.subtract(const Duration(days: 7));

    final results = await Future.wait([
      _client
          .from('browsing_history')
          .select('document_id')
          .eq('user_id', userId)
          .gte('viewed_at', todayStart.toIso8601String())
          .count(CountOption.exact),
      _client
          .from('browsing_history')
          .select('document_id')
          .eq('user_id', userId)
          .gte('viewed_at', weekStart.toIso8601String())
          .count(CountOption.exact),
      _client
          .from('browsing_history')
          .select('document_id')
          .eq('user_id', userId)
          .count(CountOption.exact),
    ]);

    return UserStats(
      todayViews: results[0].count,
      weekViews: results[1].count,
      totalViews: results[2].count,
      streakDays: streak,
    );
  }

  UserStats _loadFromCache(int streak) {
    return UserStats(
      todayViews: _prefs.getInt(_keyTodayViews) ?? 0,
      weekViews: _prefs.getInt(_keyWeekViews) ?? 0,
      totalViews: _prefs.getInt(_keyTotalViews) ?? 0,
      streakDays: streak,
    );
  }

  Future<void> _saveToCache(UserStats stats) async {
    await Future.wait([
      _prefs.setString(_keyFetchedAt, DateTime.now().toIso8601String()),
      _prefs.setInt(_keyTodayViews, stats.todayViews),
      _prefs.setInt(_keyWeekViews, stats.weekViews),
      _prefs.setInt(_keyTotalViews, stats.totalViews),
    ]);
  }

  String _todayString() {
    final d = DateTime.now();
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  // Duration(days: 1) は DST で24時間とならない場合があるため
  // DateTime コンストラクタの自動繰り下げを使う
  String _yesterdayString() {
    final now = DateTime.now();
    final d = DateTime(now.year, now.month, now.day - 1);
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }
}
