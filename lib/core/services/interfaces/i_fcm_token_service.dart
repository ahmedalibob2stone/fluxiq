abstract class IFcmTokenService {
  Future<void> saveToken(String userId);
  Future<void> updateToken(String userId, String token);
  Future<void> clearTokenAndUnsubscribe(String? userId);
}
