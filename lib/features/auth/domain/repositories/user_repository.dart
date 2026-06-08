abstract class UserRepository {
  Future<void> updateRegisteredStatus(
      {required String email, required bool isRegistered});
  Future<Map<String, dynamic>?> verifyUser(
      {required String email, required String affiliation});
  Future<Map<String, dynamic>?> verifyUserByEmail({required String email});
}
