import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Stream<User?> get authStateChanges;
  User? get currentUser;
  Future<void> signInWithEmailAndPassword({required String email, required String password});
  Future<void> createUserWithEmailAndPassword({required String email, required String password});
  Future<void> updateDisplayName(String name);
  Future<void> sendPasswordResetEmail({required String email});
  Future<void> signOut();
  Future<void> deleteUser();
  Future<void> sendEmailVerification();
  Future<void> reloadUser();
}
