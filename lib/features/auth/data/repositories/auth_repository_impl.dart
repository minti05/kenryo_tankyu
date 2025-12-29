import 'package:firebase_auth/firebase_auth.dart';
import 'package:kenryo_tankyu/core/error/error_mapper.dart';
import 'package:kenryo_tankyu/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:kenryo_tankyu/features/auth/domain/repositories/auth_repository.dart';
import 'package:kenryo_tankyu/features/auth/domain/models/auth_failure.dart';

class AuthRepositoryImpl with ErrorMapper implements AuthRepository {
  final AuthRemoteDataSource _dataSource;
  AuthRepositoryImpl(this._dataSource);

  @override
  Stream<User?> get authStateChanges => _dataSource.authStateChanges;

  @override
  User? get currentUser => _dataSource.currentUser;

  @override
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _dataSource
          .signInWithEmailAndPassword(email: email, password: password)
          .timeout(const Duration(seconds: 10));
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseException(e);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _dataSource
          .createUserWithEmailAndPassword(email: email, password: password)
          .timeout(const Duration(seconds: 10));
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseException(e);
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<void> updateDisplayName(String name) async {
    try {
      await _dataSource
          .updateDisplayName(name)
          .timeout(const Duration(seconds: 5));
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _dataSource
          .sendPasswordResetEmail(email: email)
          .timeout(const Duration(seconds: 5));
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _dataSource.signOut().timeout(const Duration(seconds: 5));
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<void> deleteUser() async {
    try {
      await _dataSource.deleteUser().timeout(const Duration(seconds: 5));
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      await _dataSource
          .sendEmailVerification()
          .timeout(const Duration(seconds: 5));
    } catch (e) {
      throw mapException(e);
    }
  }

  @override
  Future<void> reloadUser() async {
    try {
      await _dataSource.reloadUser().timeout(const Duration(seconds: 5));
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseException(e);
    } catch (e) {
      throw mapException(e);
    }
  }

  AuthFailure _mapFirebaseException(FirebaseAuthException e) {
    if (e.code == 'unavailable' || e.code == 'network-request-failed') {
      // この場合は AuthFailure のどれかにマッピングするか、Failure を投げる
      // 基盤側と合わせるなら Failure を投げたいが、Repository のシグネチャが AuthFailure を期待している場合がある
      // 今回は既存の AuthFailure に Network 系のものがないので、Unknown に入れるか追加を検討。
    }
    switch (e.code) {
      case 'user-not-found':
        return const UserNotFound();
      case 'wrong-password':
        return const WrongPassword();
      case 'email-already-in-use':
        return const EmailAlreadyInUse();
      case 'invalid-email':
        return const InvalidEmail();
      case 'weak-password':
        return const WeakPassword();
      case 'requires-recent-login':
        return const RequiresRecentLogin();
      default:
        return UnknownAuthFailure(code: e.code, message: e.message);
    }
  }
}
