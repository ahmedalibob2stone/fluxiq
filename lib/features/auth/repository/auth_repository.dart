import '../model/user_model.dart';

abstract class AuthRepository {
  Future<UserModel?> signInWithEmail(String email, String password);
  Future<UserModel?> registerWithEmail(String name, String email, String password);
  Future<void> resetPassword(String email);
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
  Future<UserModel?> checkAuthStatus();
  @override
  Future<UserModel?> signInWithGoogle();

}