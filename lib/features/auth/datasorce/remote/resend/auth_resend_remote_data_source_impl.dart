import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../../../../core/error/app_exception.dart';
import 'auth_resend_remote_data_source.dart';

class AuthResendRemoteDataSourceImpl implements AuthResendRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  AuthResendRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
  });@override
  Future<void> requestPasswordReset({required String email}) async {
    try {
      final url = '$baseUrl/auth/forgot-password';
      debugPrint('🔗 POST → $url');
      debugPrint('📧 Email: $email');

      final response = await client.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      ).timeout(const Duration(seconds: 60));

      debugPrint('📥 Status: ${response.statusCode}');
      debugPrint('📥 Body: ${response.body}');

      late final Map<String, dynamic> body;
      try {
        body = jsonDecode(response.body);
      } catch (_) {
        throw UnknownException(
          'Invalid server response (Status: ${response.statusCode})',
        );
      }

      final message = body['message'] as String? ?? 'Something went wrong';

      switch (response.statusCode) {
        case 200:
          return;
        case 400:
          throw AuthException(message);
        case 404:
          throw AuthException('This email is not registered.');
        case 422:
          throw AuthException(message);
        case 429:
          throw LimitExceededException(message);
        case >= 500:
          throw UnknownException('Server error. Please try again later.');
        default:
          throw UnknownException('Error ${response.statusCode}: $message');
      }
    } on AppException {
      rethrow;
    } on SocketException {
      throw const NetworkException('Please check your internet connection.');
    } on http.ClientException {
      throw const NetworkException('Unable to connect to server.');
    } catch (e, stackTrace) {
      debugPrint('❌ Unexpected: $e');
      debugPrint('❌ Stack: $stackTrace');

      if (e.toString().contains('TimeoutException')) {
        throw const TimeoutException('The request timed out. Please try again.');
      }
      throw const UnknownException('Something went wrong. Please try again.');
    }
  }
  @override
  Future<void> sendWelcomeEmail({
    required String name,
    required String idToken,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/email/send-welcome'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken',
        },
        body: jsonEncode({'name': name}),
      ).timeout(
        const Duration(seconds: 60),
      );

      final body = jsonDecode(response.body);
      final message = body['message'] as String? ?? 'Something went wrong';

      switch (response.statusCode) {
        case 200:
          return;
        case 401:
          throw const AuthException('Authentication failed. Please login again.');
        case 429:
          throw LimitExceededException(message);
        default:
          throw UnknownException(message);
      }
    } on AppException {
      rethrow;
    } on SocketException {
      throw const NetworkException();
    } on http.ClientException {
      throw const NetworkException('Unable to connect to server.');
    } on FormatException {
      throw const UnknownException('Received an invalid response from server.');
    } catch (e) {
      if (e.toString().contains('TimeoutException')) {
        throw const TimeoutException();
      }
      throw const UnknownException();
    }
  }

}
