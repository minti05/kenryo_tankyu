import 'dart:typed_data';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import "package:kenryo_tankyu/core/constants/work/info_value.dart";

abstract class UserArchiveRepository {
  // History
  Future<List<Searched>?> getAllHistory();
  Future<List<Searched>?> getFavoriteHistory();
  Future<void> insertHistory(Searched searched);
  Future<Searched?> getHistory(int documentID);
  Future<void> deleteHistory(int documentID);

  // Favorite (combines local DB and potentially remote updates)
  Future<void> changeFavoriteState(int documentID, bool nextIsFavorite);
  Future<bool> getFavoriteState(int documentID);
  Future<List<int>?>? getSomeFavoriteState(List<int> documentIDs);
  Future<void> updateRemoteLikes(int documentID, bool isIncrement);

  // PDF
  Future<void> insertPdf(String id, Uint8List pdfData);
  Future<Uint8List?> getLocalPdf(String id);
  Future<Uint8List?> getRemotePdf(String id, EnterYear enterYear);
  Future<Uint8List?> getPdf(String id, EnterYear enterYear);
  Future<Uint8List?> getTeacherPdf(String id);
  Future<Uint8List?> getRemotePdfForTeacher(String id);

  // Recommended Works
  Future<void> saveRecommendedWorks(Searched searched1, Searched searched2);
  Future<List<Searched>> loadRecommendedWorks();
}
