import 'package:firebase_auth/firebase_auth.dart';
import 'package:kenryo_tankyu/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:kenryo_tankyu/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _dataSource;
  AuthRepositoryImpl(this._dataSource);

  @override
  Stream<User?> get authStateChanges => _dataSource.authStateChanges;

  @override
  User? get currentUser => _dataSource.currentUser;

  @override
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) {
    return _dataSource.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) {
    return _dataSource.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> updateDisplayName(String name) async {
    await _dataSource.updateDisplayName(name);
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) {
    return _dataSource.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signOut() {
    return _dataSource.signOut();
  }

  @override
  Future<void> deleteUser() async {
    await _dataSource.deleteUser();
  }

  @override
  Future<void> sendEmailVerification() async {
    await _dataSource.sendEmailVerification();
  }

  @override
  Future<void> reloadUser() async {
    await _dataSource.reloadUser();
  }
}
