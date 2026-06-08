import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  /// Googleサインインを試みる。ユーザーがキャンセルした場合は false を返す。
  Future<bool> signInWithGoogle();
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
    final user = _firebaseAuth.currentUser;
    if (user == null) throw StateError('User not logged in');
    await user.updateDisplayName(name);
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    // Googleセッションもクリアする（メールログインユーザーには無害）
    try {
      await GoogleSignIn.instance.signOut();
    } catch (_) {}
  }

  @override
  Future<void> deleteUser() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) throw StateError('User not logged in');
    await user.delete();
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) throw StateError('User not logged in');
    await user.sendEmailVerification();
  }

  @override
  Future<void> reloadUser() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) throw StateError('User not logged in');
    await user.reload();
  }

  @override
  Future<bool> signInWithGoogle() async {
    try {
      final account = await GoogleSignIn.instance.authenticate();
      final idToken = account.authentication.idToken;
      final credential = GoogleAuthProvider.credential(idToken: idToken);
      await _firebaseAuth.signInWithCredential(credential);
      return true;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) return false;
      rethrow;
    }
  }
}

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  return AuthRemoteDataSourceImpl(ref.watch(firebaseAuthProvider));
}
