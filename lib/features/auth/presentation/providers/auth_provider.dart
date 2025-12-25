import 'package:firebase_auth/firebase_auth.dart';
import 'package:kenryo_tankyu/core/constants/const.dart';
import 'package:kenryo_tankyu/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:kenryo_tankyu/features/auth/data/repositories/user_repository_impl.dart';
import 'package:kenryo_tankyu/features/auth/domain/models/models.dart';
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

  void decrementLimit(){
    state = state.copyWith(limit: state.limit - 1);
  }

  Future<void> login(String rawEmail, String password, bool isDeveloper) async {
    final email = '$rawEmail${isDeveloper ? '@developer.com' : '@kenryo.ed.jp'}';
    await ref.read(authRepositoryProvider).signInWithEmailAndPassword(email: email, password: password);
    await ref.read(userRepositoryProvider).updateRegisteredStatus(email: email, isRegistered: true);
  }
}
