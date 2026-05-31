import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import "package:kenryo_tankyu/core/constants/feature/user_value.dart";
import 'package:kenryo_tankyu/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:kenryo_tankyu/features/auth/presentation/providers/user_repository_provider.dart';
import 'package:kenryo_tankyu/features/auth/domain/models/auth.dart';
import 'package:kenryo_tankyu/features/notification/data/datasources/notification_db.dart';
import 'package:kenryo_tankyu/features/notification/presentation/providers/read_notification_ids_provider.dart';
import 'package:kenryo_tankyu/features/search/data/datasources/search_history_data_source.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/search_history_provider.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/pdf_local_data_source.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/searched_history_local_data_source.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/providers/user_archive_providers.dart';
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
    ref.listen<AsyncValue<User?>>(
      authStateChangesProvider,
      fireImmediately: true,
      (_, next) {
        next.whenData((user) {
          if (user != null && user.emailVerified) {
            unawaited(
              ref.read(favoriteIdsCacheProvider.notifier).initialize(user.uid),
            );
            unawaited(
              ref.read(searchHistoryCacheProvider.notifier).initialize(),
            );
            unawaited(
              ref
                  .read(readNotificationIdsProvider.notifier)
                  .initialize(user.uid),
            );
          } else {
            ref.invalidate(favoriteIdsCacheProvider);
            ref.invalidate(searchHistoryCacheProvider);
            ref.invalidate(readNotificationIdsProvider);
          }
        });
      },
    );
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

  Future<void> login(String rawEmail, String password) async {
    final authRepo = ref.read(authRepositoryProvider);
    final userRepo = ref.read(userRepositoryProvider);
    final email = rawEmail.contains('@') ? rawEmail : '$rawEmail@kenryo.ed.jp';
    await authRepo.signInWithEmailAndPassword(email: email, password: password);
    await userRepo.updateRegisteredStatus(email: email, isRegistered: true);
  }

  Future<void> sendVerifyEmail() async {
    await ref.read(authRepositoryProvider).sendEmailVerification();
  }

  Future<void> reloadUser() async {
    final authRepo = ref.read(authRepositoryProvider);
    final userRepo = ref.read(userRepositoryProvider);
    await authRepo.reloadUser();
    final user = authRepo.currentUser;
    if (user?.emailVerified == true && user?.email != null) {
      await userRepo.updateRegisteredStatus(
          email: user!.email!, isRegistered: true);
    }
  }

  Future<void> createUser(String password) async {
    final authRepo = ref.read(authRepositoryProvider);
    final rawEmail = state.email ?? '';
    final email = state.affiliation == Affiliation.developer
        ? rawEmail
        : '$rawEmail@kenryo.ed.jp';
    final userName = state.userName ?? '';
    await authRepo.createUserWithEmailAndPassword(
        email: email, password: password);
    await authRepo.updateDisplayName(userName);
    await authRepo.sendEmailVerification();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    final fullEmail = email.contains('@') ? email : '$email@kenryo.ed.jp';
    await ref
        .read(authRepositoryProvider)
        .sendPasswordResetEmail(email: fullEmail);
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
  }

  Future<void> deleteAccount() async {
    final authRepo = ref.read(authRepositoryProvider);
    final userRepo = ref.read(userRepositoryProvider);
    // deleteUser()後にauthStateChangesが発火してAuthNotifierが破棄される可能性があるため、
    // ref.readで取得するデータソースは非同期処理の前にすべて退避しておく。
    final searchedHistoryDs = ref.read(searchedHistoryLocalDataSourceProvider);
    final pdfDs = ref.read(pdfLocalDataSourceProvider);
    final searchHistoryDs = ref.read(searchHistoryDataSourceProvider);

    final user = authRepo.currentUser;
    if (user == null || user.email == null) return;
    final email = user.email!;
    // Firestore更新を先に行う。Auth削除後はrequest.authがnullになりセキュリティルールで弾かれるため。
    await userRepo.updateRegisteredStatus(email: email, isRegistered: false);
    try {
      await authRepo.deleteUser();
    } catch (deleteError) {
      // Auth削除失敗時はFirestoreをロールバックして整合性を保つ。
      // ロールバック自体の失敗は握り潰し、元のエラーを必ず rethrow する。
      try {
        await userRepo.updateRegisteredStatus(email: email, isRegistered: true);
      } catch (_) {}
      rethrow;
    }
    // アカウント削除成功後、全ローカルデータを消去（失敗してもアカウント削除は成功とみなす）
    await _clearAllLocalData(
      userId: user.uid,
      searchedHistoryDs: searchedHistoryDs,
      pdfDs: pdfDs,
      searchHistoryDs: searchHistoryDs,
    );
  }

  Future<void> _clearAllLocalData({
    required String userId,
    required SearchedHistoryLocalDataSource searchedHistoryDs,
    required PdfLocalDataSource pdfDs,
    required SearchHistoryDataSource searchHistoryDs,
  }) async {
    try {
      await searchedHistoryDs.deleteAllHistory();
    } catch (_) {}
    try {
      await pdfDs.deleteAllPdf();
    } catch (_) {}
    try {
      await searchHistoryDs.deleteAllHistory(userId);
    } catch (_) {}
    try {
      await NotificationDbController.deleteAllNotifications();
    } catch (_) {}
  }
}
