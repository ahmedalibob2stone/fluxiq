import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'app_exception.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ErrorHandler {
  static AppException handle(Object error, [String? customMessage]) {
    if (error is AppException) return error;

    if (_isNetworkError(error)) {
      return const NetworkException();
    }

    if (error is FirebaseException) {
      return _handleFirebaseError(error, customMessage);
    }

    return UnknownException(
      customMessage ?? 'Something went wrong. Please try again later.',
    );
  }

  static AppException handleFirestore(Object error, [String? customMessage]) {
    if (error is AppException) return error;

    if (_isNetworkError(error)) {
      return const NetworkException();
    }

    if (error is FirebaseException) {
      return _handleFirebaseError(error, customMessage);
    }

    return UnknownException(
      customMessage ?? 'Something went wrong. Please try again later.',
    );
  }

  static bool _isNetworkError(Object error) {
    if (error is SocketException) return true;
    if (error is http.ClientException) return true;

    if (error is FirebaseException) {
      return error.code == 'unavailable' ||
          error.code == 'network-request-failed';
    }

    return false;
  }

  static AppException _handleFirebaseError(
      FirebaseException error, [
        String? customMessage,
      ]) {
    switch (error.code) {
      case 'permission-denied':
        return const PermissionException();

      case 'not-found':
        return const NotFoundException();

      case 'deadline-exceeded':
        return const TimeoutException();

      case 'unavailable':
      case 'network-request-failed':
        return const NetworkException();

      default:
        return FirestoreException(
          customMessage ?? 'Something went wrong. Please try again later.',
        );
    }
  }
}