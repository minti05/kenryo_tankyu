import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kenryo_tankyu/core/error/error_mapper.dart';
import 'package:kenryo_tankyu/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl with ErrorMapper implements UserRepository {
  final FirebaseFirestore _firestore;
  UserRepositoryImpl(this._firestore);

  @override
  Future<void> updateRegisteredStatus(
      {required String email, required bool isRegistered}) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get()
          .timeout(const Duration(seconds: 5));

      if (snapshot.docs.isNotEmpty) {
        await snapshot.docs.first.reference.update({
          'registered': isRegistered,
        }).timeout(const Duration(seconds: 5));
      }
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<Map<String, dynamic>?> verifyUser(
      {required String email, required String affiliation}) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .where('affiliation', isEqualTo: affiliation)
          .limit(1)
          .get()
          .timeout(const Duration(seconds: 5));

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.data();
      }
      return null;
    } catch (e) {
      throw mapException(e);
    }
  }
}
