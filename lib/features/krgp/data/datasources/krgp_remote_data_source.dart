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
    final doc = await _firestore.collection('krgp').doc('awards').get();
    final docData = doc.data();
    if (docData == null) return [];

    final rawWorks = docData['works'] as List<dynamic>? ?? [];
    final results = <Searched>[];

    for (final item in rawWorks) {
      try {
        final map = Map<String, dynamic>.from(item as Map);
        final documentID = (map['documentID'] as num?)?.toInt() ?? 0;
        // documentID は fromJson で無視されるフィールドなので copyWith で後付け
        map.putIfAbsent('likes', () => 0);
        map.putIfAbsent('existsSlide', () => false);
        map.putIfAbsent('existsReport', () => false);
        map.putIfAbsent('existsThesis', () => false);
        map.putIfAbsent('existsPoster', () => false);
        final searched = Searched.fromJson(map);
        results.add(searched.copyWith(
          documentID: documentID,
          isFavorite: false,
          isCached: false,
        ));
      } catch (e) {
        debugPrint('[KrgpDataSource] parse error: $e\nitem: $item');
      }
    }

    return results;
  }
}
