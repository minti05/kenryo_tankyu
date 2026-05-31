import 'package:kenryo_tankyu/core/providers/supabase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'favorites_remote_data_source.g.dart';

@Riverpod(keepAlive: true)
FavoritesRemoteDataSource favoritesRemoteDataSource(Ref ref) {
  return FavoritesRemoteDataSource(ref.watch(supabaseClientProvider));
}

class FavoritesRemoteDataSource {
  FavoritesRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<Set<int>> getFavoriteIds(String userId) async {
    final rows = await _client
        .from('favorites')
        .select('document_id')
        .eq('user_id', userId);
    return rows.map<int>((r) => r['document_id'] as int).toSet();
  }

  Future<void> addFavorite(String userId, int documentId) async {
    await _client.from('favorites').upsert({
      'user_id': userId,
      'document_id': documentId,
    });
  }

  Future<void> removeFavorite(String userId, int documentId) async {
    await _client
        .from('favorites')
        .delete()
        .eq('user_id', userId)
        .eq('document_id', documentId);
  }

  Future<bool> isFavorite(String userId, int documentId) async {
    final row = await _client
        .from('favorites')
        .select('document_id')
        .eq('user_id', userId)
        .eq('document_id', documentId)
        .maybeSingle();
    return row != null;
  }
}
