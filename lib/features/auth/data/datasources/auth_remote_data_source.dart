import 'package:firebase_auth/firebase_auth.dart';
import 'package:kenryo_tankyu/core/providers/firebase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_data_source.g.dart';

abstract class AuthRemoteDataSource {
  Stream<User?> get authStateChanges;
  User? get currentUser;
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password});
  Future<void> updateDisplayName(String name);
  Future<void> sendPasswordResetEmail({required String email});
  Future<void> signOut();
  Future<void> deleteUser();
  Future<void> sendEmailVerification();
  Future<void> reloadUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  AuthRemoteDataSourceImpl(this._firebaseAuth);

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.userChanges();

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) {
    return _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> updateDisplayName(String name) async {
    await _firebaseAuth.currentUser?.updateDisplayName(name);
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  @override
  Future<void> deleteUser() async {
    await _firebaseAuth.currentUser?.delete();
  }

  @override
  Future<void> sendEmailVerification() async {
    await _firebaseAuth.currentUser?.sendEmailVerification();
  }

  @override
  Future<void> reloadUser() async {
    await _firebaseAuth.currentUser?.reload();
  }
}

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  return AuthRemoteDataSourceImpl(ref.watch(firebaseAuthProvider));
}
