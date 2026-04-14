
  sealed class AppException implements Exception {
    final String message;
    const AppException(this.message);
  }
  class NetworkException extends AppException {
    const NetworkException([
      String message = 'Please check your internet connection.',
    ]) : super(message);
  }
  class PermissionException extends AppException {
    const PermissionException([
      String message = "You don't have permission to perform this action.",
    ]) : super(message);
  }
  class NotFoundException extends AppException {
    const NotFoundException([
      String message = 'Requested resource was not found.',
    ]) : super(message);
  }
  class TimeoutException extends AppException {
    const TimeoutException([
      String message = 'The request timed out. Please try again.',
    ]) : super(message);
  }
  class FirestoreException extends AppException {
    const FirestoreException([
      String message = 'Something went wrong. Please try again later.',
    ]) : super(message);
  }
  class AuthException extends AppException {
    const AuthException([
      String message = 'An authentication error occurred.',
    ]) : super(message);
  }

  class UnknownException extends AppException {
    const UnknownException([
      String message = 'Something went wrong. Please try again later.',
    ]) : super(message);
  }

  class LimitExceededException extends AppException {
    const LimitExceededException([
      String message = 'You have reached the maximum share limit',
    ]) : super(message);
  }