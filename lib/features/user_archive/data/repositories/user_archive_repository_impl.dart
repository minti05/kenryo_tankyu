import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kenryo_tankyu/core/constants/work/info_value.dart';
import 'package:kenryo_tankyu/core/error/error_mapper.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/browsing_history_data_source.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/favorites_remote_data_source.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/pdf_local_data_source.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/recommended_works_local_data_source.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/user_archive_remote_data_source.dart';
import 'package:kenryo_tankyu/features/user_archive/domain/models/archive_stats.dart';
import 'package:kenryo_tankyu/features/user_archive/domain/repositories/user_archive_repository.dart';

class UserArchiveRepositoryImpl
    with ErrorMapper
    implements UserArchiveRepository {
  final BrowsingHistoryDataSource _browsingHistoryDataSource;
  final FavoritesRemoteDataSource _favoritesDataSource;
  final PdfLocalDataSource _pdfDataSource;
  final RecommendedWorksLocalDataSource _recommendedDataSource;
  final UserArchiveRemoteDataSource _remoteDataSource;

  UserArchiveRepositoryImpl(
    this._browsingHistoryDataSource,
    this._favoritesDataSource,
    this._pdfDataSource,
    this._recommendedDataSource,
    this._remoteDataSource,
  );

  @override
  Future<List<Searched>?> getAllHistory() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return null;
    try {
      return await _browsingHistoryDataSource.getAllHistory(userId);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<List<Searched>?> getFavoriteHistory() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return null;
    try {
      final favoriteIds = await _favoritesDataSource.getFavoriteIds(userId);
      if (favoriteIds.isEmpty) return null;
      return await _browsingHistoryDataSource.getHistoryByIds(
          userId, favoriteIds);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<void> insertHistory(Searched searched) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;
    try {
      await _browsingHistoryDataSource.recordView(userId, searched);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<Searched?> getHistory(int documentID) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return null;
    try {
      return await _browsingHistoryDataSource.getHistory(userId, documentID);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<void> deleteHistory(int documentID) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;
    try {
      await _browsingHistoryDataSource.deleteHistory(userId, documentID);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<void> deleteHistoryWithFavorite(int documentID) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;
    try {
      // Postgres トランザクション（RPC）で browsing_history + favorites を原子的に削除
      await _browsingHistoryDataSource.deleteHistoryAndFavorite(
          userId, documentID);
    } catch (e) {
      throw mapException(e);
    }
    // Firestore の likes をデクリメント（失敗しても無視）
    try {
      await updateRemoteLikes(documentID, false);
    } catch (_) {}
  }

  @override
  Future<void> deleteAllHistory() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;
    try {
      await _browsingHistoryDataSource.deleteAllHistory(userId);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<void> deleteHistoryBefore(DateTime date) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;
    try {
      await _browsingHistoryDataSource.deleteHistoryBefore(userId, date);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<HistoryStats> getHistoryStats() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return (count: 0, oldest: null, newest: null);
    try {
      return await _browsingHistoryDataSource.getHistoryStats(userId);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<List<DateTime>> getAllHistorySavedDates() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return [];
    try {
      return await _browsingHistoryDataSource.getAllViewedDates(userId);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<void> updateHistoryWork(int documentID, Searched latest) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;
    try {
      await _browsingHistoryDataSource.updateWorkInHistory(
          userId, documentID, latest);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<void> updateHistoryViewedAt(int documentID) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;
    try {
      await _browsingHistoryDataSource.updateViewedAt(userId, documentID);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<void> changeFavoriteState(int documentID, bool nextIsFavorite) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) throw mapException(Exception('ログインしていません'));

    // Supabase favorites テーブルを更新（主ストア）
    if (nextIsFavorite) {
      await _favoritesDataSource.addFavorite(userId, documentID);
    } else {
      await _favoritesDataSource.removeFavorite(userId, documentID);
    }

    // Firestore の likes カウントを更新（失敗時は Supabase をロールバック）
    try {
      await updateRemoteLikes(documentID, nextIsFavorite);
    } catch (e) {
      try {
        if (nextIsFavorite) {
          await _favoritesDataSource.removeFavorite(userId, documentID);
        } else {
          await _favoritesDataSource.addFavorite(userId, documentID);
        }
      } catch (_) {}
      throw mapException(e);
    }

    // browsing_history の likes をバックグラウンドで更新（失敗しても無視）
    _updateBrowsingHistoryLikesSilently(
        userId, documentID, nextIsFavorite ? 1 : -1);
  }

  void _updateBrowsingHistoryLikesSilently(
      String userId, int documentID, int delta) {
    _browsingHistoryDataSource
        .updateLikes(userId, documentID, delta)
        .catchError((_) {});
  }

  @override
  Future<void> updateRemoteLikes(int documentID, bool isIncrement) async {
    try {
      await _remoteDataSource
          .updateRemoteLikes(documentID, isIncrement)
          .timeout(const Duration(seconds: 5));
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<bool> getFavoriteState(int documentID) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return false;
    try {
      return await _favoritesDataSource.isFavorite(userId, documentID);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<List<int>?>? getSomeFavoriteState(List<int> documentIDs) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return null;
    try {
      final favoriteIds = await _favoritesDataSource.getFavoriteIds(userId);
      final result =
          documentIDs.where((id) => favoriteIds.contains(id)).toList();
      return result.isEmpty ? null : result;
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<void> insertPdf(String id, Uint8List pdfData) async {
    try {
      await _pdfDataSource.insertPdf(id, pdfData);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<Uint8List?> getLocalPdf(String id) async {
    try {
      return await _pdfDataSource.getLocalPdf(id);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<Uint8List?> getRemotePdf(String id, EnterYear enterYear) async {
    try {
      return await _pdfDataSource
          .getRemotePdf(id, enterYear)
          .timeout(const Duration(seconds: 10));
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<Uint8List?> getPdf(String id, EnterYear enterYear) async {
    try {
      final localData = await _pdfDataSource.getLocalPdf(id);
      if (localData != null) {
        return localData;
      }
      return await _pdfDataSource
          .getRemotePdf(id, enterYear)
          .timeout(const Duration(seconds: 10));
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<Uint8List?> getTeacherPdf(String id) async {
    try {
      final localData = await _pdfDataSource.getLocalPdf(id);
      if (localData != null) {
        return localData;
      }
      return await _pdfDataSource
          .getRemotePdfForTeacher(id)
          .timeout(const Duration(seconds: 10));
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<Uint8List?> getRemotePdfForTeacher(String id) async {
    try {
      return await _pdfDataSource
          .getRemotePdfForTeacher(id)
          .timeout(const Duration(seconds: 10));
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<void> deleteAllPdfCache() async {
    try {
      await _pdfDataSource.deleteAllPdf();
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<void> deletePdfCacheBefore(DateTime date) async {
    try {
      await _pdfDataSource.deletePdfBefore(date);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<PdfCacheStats> getPdfCacheStats() async {
    try {
      return await _pdfDataSource.getPdfCacheStats();
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<List<PdfCacheEntry>> getAllPdfCacheEntries() async {
    try {
      return await _pdfDataSource.getAllCacheEntries();
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<void> saveRecommendedWorks(
      Searched searched1, Searched searched2) async {
    try {
      await _recommendedDataSource.save(searched1, searched2);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<List<Searched>> loadRecommendedWorks() async {
    try {
      return await _recommendedDataSource.load();
    } catch (e) {
      throw mapException(e);
    }
  }
}
