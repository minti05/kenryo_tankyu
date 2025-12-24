abstract class UserRepository {
  Future<void> updateRegisteredStatus({required String email, required bool isRegistered});
}
