import 'package:firebase_auth/firebase_auth.dart';
import "package:kenryo_tankyu/core/constants/feature/user_value.dart";
import 'package:kenryo_tankyu/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:kenryo_tankyu/features/auth/presentation/providers/user_repository_provider.dart';
import 'package:kenryo_tankyu/features/auth/domain/models/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
Stream<User?> authStateChanges(Ref ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
}

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Auth build() {
    return const Auth();
  }

  void changeVerifyEmail() {
    state = state.copyWith(confirmVerifyEmail: !state.confirmVerifyEmail);
  }

  void changeUserName(String userName) {
    state = state.copyWith(userName: userName);
  }

  void changeAffiliation(Affiliation affiliation) {
    state = state.copyWith(affiliation: affiliation);
  }

  void changeEmail(String email) {
    state = state.copyWith(email: email);
  }

  void changePassword(String password) {
    state = state.copyWith(password: password);
  }

  void decrementLimit() {
    state = state.copyWith(limit: state.limit - 1);
  }

  Future<void> login(String rawEmail, String password, bool isDeveloper) async {
    final email =
        '$rawEmail${isDeveloper ? '@developer.com' : '@kenryo.ed.jp'}';
    await ref
        .read(authRepositoryProvider)
        .signInWithEmailAndPassword(email: email, password: password);
    await ref
        .read(userRepositoryProvider)
        .updateRegisteredStatus(email: email, isRegistered: true);
  }

  Future<void> sendVerifyEmail() async {
    await ref.read(authRepositoryProvider).sendEmailVerification();
  }

  Future<void> reloadUser() async {
    await ref.read(authRepositoryProvider).reloadUser();
  }

  Future<void> createUser(String password) async {
    final email = '${state.email}@kenryo.ed.jp';
    await ref
        .read(authRepositoryProvider)
        .createUserWithEmailAndPassword(email: email, password: password);
    await ref
        .read(authRepositoryProvider)
        .updateDisplayName(state.userName ?? '');
    await ref.read(authRepositoryProvider).sendEmailVerification();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    final fullEmail = '$email@kenryo.ed.jp';
    await ref
        .read(authRepositoryProvider)
        .sendPasswordResetEmail(email: fullEmail);
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
  }

  Future<void> deleteAccount() async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user != null && user.email != null) {
      // 本来はTransactionなどでやるべきだが簡易的に
      try {
        await ref
            .read(userRepositoryProvider)
            .updateRegisteredStatus(email: user.email!, isRegistered: false);
        await ref.read(authRepositoryProvider).deleteUser();
      } catch (e) {
        rethrow;
      }
    }
  }
}
