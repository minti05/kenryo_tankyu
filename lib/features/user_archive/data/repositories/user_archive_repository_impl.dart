import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kenryo_tankyu/core/constants/const.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/models.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/pdf_db.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/recommended_works_db.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/searched_history_db.dart';
import 'package:kenryo_tankyu/features/user_archive/domain/repositories/repositories.dart';

class UserArchiveRepositoryImpl implements UserArchiveRepository {
  final SearchedHistoryDataSource _historyDataSource;
  final PdfDbDataSource _pdfDataSource;
  final RecommendedWorksDataSource _recommendedDataSource;
  final FirebaseFirestore _firestore;

  UserArchiveRepositoryImpl(
    this._historyDataSource,
    this._pdfDataSource,
    this._recommendedDataSource,
    this._firestore,
  );

  @override
  Future<List<Searched>?> getAllHistory() {
    return _historyDataSource.getAllHistory();
  }

  @override
  Future<List<Searched>?> getFavoriteHistory() {
    return _historyDataSource.getFavoriteHistory();
  }

  @override
  Future<void> insertHistory(Searched searched) {
    return _historyDataSource.insertHistory(searched);
  }

  @override
  Future<Searched?> getHistory(int documentID) {
    return _historyDataSource.getHistory(documentID);
  }

  @override
  Future<void> deleteHistory(int documentID) {
    return _historyDataSource.deleteHistory(documentID);
  }

  @override
  Future<void> changeFavoriteState(int documentID, bool nextIsFavorite) async {
    await _historyDataSource.changeFavoriteState(documentID, nextIsFavorite);
    // Also update remote likes here?
    // The previous implementation in ChangeFavoriteNotifier did both.
    // Ideally, Repository calls both.
    await updateRemoteLikes(documentID, nextIsFavorite);
  }

  @override
  Future<void> updateRemoteLikes(int documentID, bool isIncrement) async {
    final docRef = _firestore.collection('works').doc(documentID.toString());
    final increment = isIncrement ? 1 : -1;
    await docRef.update({
      'exactLikes': FieldValue.increment(increment),
      'vagueLikes': FieldValue.increment(increment)
    });
  }

  @override
  Future<bool> getFavoriteState(int documentID) {
    return _historyDataSource.getFavoriteState(documentID);
  }

  @override
  Future<List<int>?>? getSomeFavoriteState(List<int> documentIDs) {
    return _historyDataSource.getSomeFavoriteState(documentIDs);
  }

  @override
  Future<void> insertPdf(String id, Uint8List pdfData) {
    return _pdfDataSource.insertPdf(id, pdfData);
  }

  @override
  Future<Uint8List?> getLocalPdf(String id) {
    return _pdfDataSource.getLocalPdf(id);
  }

  @override
  Future<Uint8List?> getRemotePdf(String id, EnterYear enterYear) {
    return _pdfDataSource.getRemotePdf(id, enterYear);
  }

  @override
  Future<Uint8List?> getRemotePdfForTeacher(String id) {
    return _pdfDataSource.getRemotePdfForTeacher(id);
  }

  @override
  Future<void> saveRecommendedWorks(Searched searched1, Searched searched2) {
    return _recommendedDataSource.save(searched1, searched2);
  }

  @override
  Future<List<Searched>> loadRecommendedWorks() {
    return _recommendedDataSource.load();
  }
}
