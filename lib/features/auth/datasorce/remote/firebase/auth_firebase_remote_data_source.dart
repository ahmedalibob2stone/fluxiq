

import '../../../model/user_model.dart';
typedef RegisterResult = ({UserModel user, String? idToken});
typedef GoogleSignInResult = ({UserModel? user, String? idToken, bool isNewUser});
abstract class AuthFirebaseRemoteDataSource {
  Future<UserModel?> signInWithEmail(String email, String password);

  Future<RegisterResult> registerWithEmail(
      String name,
      String email,
      String password,
      );

  Future<void> signOut();

  Future<UserModel?> getCurrentUser();

  Future<UserModel?> checkAuthStatus();

  Future<GoogleSignInResult> signInWithGoogle();
}


