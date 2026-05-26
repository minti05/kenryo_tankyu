import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kenryo_tankyu/core/providers/firebase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_archive_remote_data_source.g.dart';

abstract class UserArchiveRemoteDataSource {
  Future<void> updateRemoteLikes(int documentID, bool isIncrement);
}

class UserArchiveRemoteDataSourceImpl implements UserArchiveRemoteDataSource {
  final FirebaseFirestore _firestore;

  UserArchiveRemoteDataSourceImpl(this._firestore);

  @override
  Future<void> updateRemoteLikes(int documentID, bool isIncrement) async {
    final docRef = _firestore.collection('works').doc(documentID.toString());
    final increment = isIncrement ? 1 : -1;
    // TODO: 将来的には Firestore 側も 'likes' に統一する可能性があるが、
    // 現状は既存の 'exactLikes' と 'vagueLikes' の両方を更新して整合性を保つ。
    await docRef.update({
      'exactLikes': FieldValue.increment(increment),
      'vagueLikes': FieldValue.increment(increment)
    });
  }
}

@riverpod
UserArchiveRemoteDataSource userArchiveRemoteDataSource(Ref ref) {
  return UserArchiveRemoteDataSourceImpl(ref.watch(firebaseFirestoreProvider));
}
