
import 'package:flutter/cupertino.dart';

import '../datasorce/remote/firebase/auth_firebase_remote_data_source.dart';
import '../datasorce/remote/resend/auth_resend_remote_data_source.dart';
import '../model/user_model.dart';
import 'auth_repository.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthFirebaseRemoteDataSource _firebaseDataSource;
  final AuthResendRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl({
    required AuthFirebaseRemoteDataSource firebaseDataSource,
    required AuthResendRemoteDataSource remoteDataSource,
  })  : _firebaseDataSource = firebaseDataSource,
        _remoteDataSource = remoteDataSource;


  @override
  Future<UserModel?> signInWithEmail(String email, String password) =>
      _firebaseDataSource.signInWithEmail(email, password);


  @override
  Future<UserModel?> registerWithEmail(
      String name,
      String email,
      String password,
      ) async {
    final result =
    await _firebaseDataSource.registerWithEmail(name, email, password);

    if (result.idToken != null) {
      _sendWelcomeEmailInBackground(
        name: name,
        idToken: result.idToken!,
      );
    }

    return result.user;
  }


  @override
  Future<void> resetPassword(String email) =>
      _remoteDataSource.requestPasswordReset(email: email);


  @override
  Future<void> signOut() => _firebaseDataSource.signOut();


  @override
  Future<UserModel?> getCurrentUser() => _firebaseDataSource.getCurrentUser();


  @override
  Future<UserModel?> checkAuthStatus() =>
      _firebaseDataSource.checkAuthStatus();


  @override
  Future<UserModel?> signInWithGoogle() async {
    final result = await _firebaseDataSource.signInWithGoogle();

    if (result.isNewUser && result.idToken != null && result.user != null) {
      _sendWelcomeEmailInBackground(
        name: result.user!.name,
        idToken: result.idToken!,
      );
    }

    return result.user;
  }


  void _sendWelcomeEmailInBackground({
    required String name,
    required String idToken,
  }) {
    _remoteDataSource
        .sendWelcomeEmail(name: name, idToken: idToken)
        .then((_) => debugPrint('***** Welcome email sent successfully*****'))
        .catchError(
          (e) => debugPrint('⚠️ Welcome email failed (non-critical): $e'),
    );
  }
}