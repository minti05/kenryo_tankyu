import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'krgp_remote_data_source.g.dart';

// Firestore path: collection 'krgp', subcollection 'awards'
// krgp/{year}/awards/{docId} → collectionGroup('awards')
// または collection('krgp') の場合はここを変更
const _kKrgpCollection = 'krgp';

@riverpod
KrgpRemoteDataSource krgpRemoteDataSource(Ref ref) {
  return KrgpRemoteDataSource(FirebaseFirestore.instance);
}

class KrgpRemoteDataSource {
  final FirebaseFirestore _firestore;
  const KrgpRemoteDataSource(this._firestore);

  Future<List<Searched>> fetchAllAwards() async {
    final snapshot = await _firestore.collection(_kKrgpCollection).get();
    return snapshot.docs.map((doc) {
      return Searched.fromFirestore(doc, false);
    }).toList();
  }
}
