abstract class AuthResendRemoteDataSource {
  Future<void> requestPasswordReset({required String email});
  Future<void> sendWelcomeEmail({
    required String name,
    required String idToken,
  });
}

