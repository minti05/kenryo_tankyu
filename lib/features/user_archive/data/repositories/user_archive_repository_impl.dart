import 'dart:typed_data';
import 'package:kenryo_tankyu/core/constants/work/info_value.dart';
import 'package:kenryo_tankyu/core/error/error_mapper.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/pdf_local_data_source.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/recommended_works_local_data_source.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/searched_history_local_data_source.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/user_archive_remote_data_source.dart';
import 'package:kenryo_tankyu/features/user_archive/domain/repositories/user_archive_repository.dart';

class UserArchiveRepositoryImpl
    with ErrorMapper
    implements UserArchiveRepository {
  final SearchedHistoryLocalDataSource _historyDataSource;
  final PdfLocalDataSource _pdfDataSource;
  final RecommendedWorksLocalDataSource _recommendedDataSource;
  final UserArchiveRemoteDataSource _remoteDataSource;

  UserArchiveRepositoryImpl(
    this._historyDataSource,
    this._pdfDataSource,
    this._recommendedDataSource,
    this._remoteDataSource,
  );

  @override
  Future<List<Searched>?> getAllHistory() async {
    try {
      return await _historyDataSource.getAllHistory();
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<List<Searched>?> getFavoriteHistory() async {
    try {
      return await _historyDataSource.getFavoriteHistory();
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<void> insertHistory(Searched searched) async {
    try {
      await _historyDataSource.insertHistory(searched);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<Searched?> getHistory(int documentID) async {
    try {
      return await _historyDataSource.getHistory(documentID);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<void> deleteHistory(int documentID) async {
    try {
      await _historyDataSource.deleteHistory(documentID);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<void> changeFavoriteState(int documentID, bool nextIsFavorite) async {
    try {
      await _historyDataSource.changeFavoriteState(documentID, nextIsFavorite);
      await updateRemoteLikes(documentID, nextIsFavorite);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<void> updateRemoteLikes(int documentID, bool isIncrement) async {
    try {
      await _remoteDataSource.updateRemoteLikes(documentID, isIncrement);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<bool> getFavoriteState(int documentID) async {
    try {
      return await _historyDataSource.getFavoriteState(documentID);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<List<int>?>? getSomeFavoriteState(List<int> documentIDs) async {
    try {
      return await _historyDataSource.getSomeFavoriteState(documentIDs);
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
      return await _pdfDataSource.getRemotePdf(id, enterYear);
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
      return await _pdfDataSource.getRemotePdf(id, enterYear);
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
      return await _pdfDataSource.getRemotePdfForTeacher(id);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<Uint8List?> getRemotePdfForTeacher(String id) async {
    try {
      return await _pdfDataSource.getRemotePdfForTeacher(id);
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
