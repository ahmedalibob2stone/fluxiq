
import 'package:firebase_auth/firebase_auth.dart';
import 'app_exception.dart';
import 'firestore_error_handler.dart';

class AuthErrorHandler {

  static AppException handle(Object error) {
    if (error is AppException) return error;
    if (error is FirebaseAuthException) {
      return _handleAuthError(error);
    }
    return ErrorHandler.handle(error);
  }
  static AppException _handleAuthError(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-credential':
      case 'user-not-found':
      case 'wrong-password':
        return const AuthException(
          'The email or password you entered is incorrect.',
        );

      case 'invalid-email':
        return const AuthException(
          'Please enter a valid email address format.',
        );

      case 'email-already-in-use':
        return const AuthException(
          'An account already exists with this email address.',
        );

      case 'weak-password':
        return const AuthException(
          'Your password is too weak. Please use at least 6 characters.',
        );

      case 'account-exists-with-different-credential':
        return const AuthException(
          'An account already exists with the same email but a different sign-in method.',
        );

      case 'network-request-failed':
        return const NetworkException();

      case 'too-many-requests':
        return const AuthException(
          'Too many attempts. Please try again later.',
        );

      case 'popup-closed-by-user':
        return const AuthException(
          'The authentication flow was cancelled.',
        );

      default:
        return AuthException(
          error.message ?? 'An unexpected authentication error occurred.',
        );
    }
  }
}