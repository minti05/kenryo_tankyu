import 'package:kenryo_tankyu/core/providers/supabase_provider.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/user_archive/domain/models/archive_stats.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'browsing_history_data_source.g.dart';

@Riverpod(keepAlive: true)
BrowsingHistoryDataSource browsingHistoryDataSource(Ref ref) {
  return BrowsingHistoryDataSource(ref.watch(supabaseClientProvider));
}

class BrowsingHistoryDataSource {
  BrowsingHistoryDataSource(this._client);

  final SupabaseClient _client;

  Future<List<Searched>?> getAllHistory(String userId) async {
    final rows = await _client
        .from('browsing_history')
        .select()
        .eq('user_id', userId)
        .order('viewed_at', ascending: false);
    if (rows.isEmpty) return null;
    return rows.map((r) => Searched.fromSupabase(r)).toList();
  }

  Future<List<Searched>?> getHistoryByIds(
      String userId, Set<int> documentIds) async {
    if (documentIds.isEmpty) return null;
    final rows = await _client
        .from('browsing_history')
        .select()
        .eq('user_id', userId)
        .inFilter('document_id', documentIds.toList())
        .order('viewed_at', ascending: false);
    if (rows.isEmpty) return null;
    return rows.map((r) => Searched.fromSupabase(r, isFavorite: true)).toList();
  }

  /// 閲覧履歴を記録する。既存レコードがあれば全フィールドを上書き（upsert）
  /// recordView は常にサーバーフェッチ直後に呼ばれるため、データは常に最新
  Future<void> recordView(String userId, Searched work) async {
    await _client.from('browsing_history').upsert({
      'user_id': userId,
      ...work.toSupabase(),
      'viewed_at': DateTime.now().toUtc().toIso8601String(),
    });
  }

  Future<Searched?> getHistory(String userId, int documentID) async {
    final row = await _client
        .from('browsing_history')
        .select()
        .eq('user_id', userId)
        .eq('document_id', documentID)
        .maybeSingle();
    return row == null ? null : Searched.fromSupabase(row);
  }

  Future<void> deleteHistory(String userId, int documentID) async {
    await _client
        .from('browsing_history')
        .delete()
        .eq('user_id', userId)
        .eq('document_id', documentID);
  }

  Future<void> deleteAllHistory(String userId) async {
    await _client.from('browsing_history').delete().eq('user_id', userId);
  }

  Future<void> deleteHistoryBefore(String userId, DateTime date) async {
    await _client
        .from('browsing_history')
        .delete()
        .eq('user_id', userId)
        .lt('viewed_at', date.toUtc().toIso8601String());
  }

  Future<List<DateTime>> getAllViewedDates(String userId) async {
    final rows = await _client
        .from('browsing_history')
        .select('viewed_at')
        .eq('user_id', userId);
    return rows
        .map<DateTime>(
            (r) => DateTime.parse(r['viewed_at'] as String).toLocal())
        .toList();
  }

  Future<HistoryStats> getHistoryStats(String userId) async {
    final rows = await _client
        .from('browsing_history')
        .select('viewed_at')
        .eq('user_id', userId);
    if (rows.isEmpty) return (count: 0, oldest: null, newest: null);
    final dates = rows
        .map<DateTime>(
            (r) => DateTime.parse(r['viewed_at'] as String).toLocal())
        .toList()
      ..sort();
    return (count: dates.length, oldest: dates.first, newest: dates.last);
  }

  /// キャッシュヒット時に viewed_at のみ更新（帯域節約）
  Future<void> updateViewedAt(String userId, int documentId) async {
    await _client
        .from('browsing_history')
        .update({'viewed_at': DateTime.now().toUtc().toIso8601String()})
        .eq('user_id', userId)
        .eq('document_id', documentId);
  }

  /// お気に入り操作に伴う likes の差分更新（現在値を取得してから +delta）
  Future<void> updateLikes(String userId, int documentID, int delta) async {
    final row = await _client
        .from('browsing_history')
        .select('likes')
        .eq('user_id', userId)
        .eq('document_id', documentID)
        .maybeSingle();
    if (row == null) return;
    final current = row['likes'] as int;
    await _client
        .from('browsing_history')
        .update({'likes': (current + delta).clamp(0, 999999)})
        .eq('user_id', userId)
        .eq('document_id', documentID);
  }

  /// likes 等の作品データを最新値で更新（viewed_at は変更しない）
  Future<void> updateWorkInHistory(
      String userId, int documentID, Searched latest) async {
    final data = latest.toSupabase();
    data.remove('document_id');
    await _client
        .from('browsing_history')
        .update(data)
        .eq('user_id', userId)
        .eq('document_id', documentID);
  }
}
