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
        results
            .add(Searched.fromKrgpDb(Map<String, dynamic>.from(item as Map)));
      } catch (e) {
        debugPrint('[KrgpDataSource] parse error: $e\nitem: $item');
      }
    }

    return results;
  }
}
