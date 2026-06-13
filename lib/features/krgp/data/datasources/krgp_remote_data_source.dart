import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'krgp_remote_data_source.g.dart';

@riverpod
KrgpRemoteDataSource krgpRemoteDataSource(Ref ref) {
  return KrgpRemoteDataSource(FirebaseFirestore.instance);
}

class KrgpRemoteDataSource {
  final FirebaseFirestore _firestore;
  const KrgpRemoteDataSource(this._firestore);

  Future<List<Searched>> fetchAllAwards() async {
    final snapshot = await _firestore.collection('krgp').get();
    final results = <Searched>[];
    for (final doc in snapshot.docs) {
      try {
        final data = Map<String, dynamic>.from(doc.data());
        _normalizeData(data, doc.id);
        final searched = Searched.fromJson(data);
        final documentID = int.tryParse(doc.id) ?? 0;
        results.add(searched.copyWith(
          documentID: documentID,
          isFavorite: false,
          isCached: false,
        ));
      } catch (e) {
        debugPrint('[KrgpDataSource] doc ${doc.id} parse error: $e');
      }
    }
    return results;
  }

  // Firestoreの型ゆらぎを吸収する
  void _normalizeData(Map<String, dynamic> data, String docId) {
    // awardType が String で来た場合 ("grand"/"excellent" 等) を int に変換
    final rawAwardType = data['awardType'];
    if (rawAwardType is String) {
      final byName = {
        'grand': 1,
        'excellent': 2,
        'encouragement': 3,
        'honorable': 4,
      };
      data['awardType'] = byName[rawAwardType];
    }

    // enterYear が String で来た場合を int に変換
    final rawEnterYear = data['enterYear'];
    if (rawEnterYear is String) {
      data['enterYear'] = int.tryParse(rawEnterYear);
    }

    // likes が存在しない場合はデフォルト値
    data.putIfAbsent('likes', () => 0);

    // exist系フラグが存在しない場合はデフォルト値
    for (final key in [
      'existsSlide',
      'existsReport',
      'existsThesis',
      'existsPoster',
    ]) {
      data.putIfAbsent(key, () => false);
    }
  }
}
