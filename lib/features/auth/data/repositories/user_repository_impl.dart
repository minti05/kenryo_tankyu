import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kenryo_tankyu/core/providers/firebase_providers.dart';
import 'package:kenryo_tankyu/features/auth/domain/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository_impl.g.dart';

@riverpod
UserRepository userRepository(Ref ref) {
  return UserRepositoryImpl(ref.watch(firebaseFirestoreProvider));
}

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore;
  UserRepositoryImpl(this._firestore);

  @override
  Future<void> updateRegisteredStatus({required String email, required bool isRegistered}) async {
    final snapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      await snapshot.docs.first.reference.update({
        'registered': isRegistered,
      });
    }
  }

  @override
  Future<Map<String, dynamic>?> verifyUser({required String email, required String affiliation}) async {
    final snapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .where('affiliation', isEqualTo: affiliation)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.data();
    }
    return null;
  }
}
