
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'notification_remote_datasource.dart';

class NotificationRemoteDataSourceImpl
    implements NotificationRemoteDataSource {
  final Dio _dio;
  final String baseUrl;
  NotificationRemoteDataSourceImpl(this._dio, this.baseUrl);


  @override
  Future<void> sendLikeNotification({
    required String newsId,
    required String newsTitle,
    required String newsImageUrl,
    required String authorId,
    required String senderId,
    required String senderUsername,
    required int currentLikesCount,
  }) async {
    if (baseUrl.isEmpty) {
      debugPrint('[NotificationRemoteDS] RENDER_API_URL not set in .env');
      return;
    }

    try {
      await _dio.post(
        '$baseUrl/notifications/like',

        data: {
          'newsId': newsId,
          'newsTitle': newsTitle,
          'newsImageUrl': newsImageUrl,
          'authorId': authorId,
          'senderId': senderId,
          'senderUsername': senderUsername,
          'currentLikesCount': currentLikesCount,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 15),
        ),
      );
    } on DioException catch (e) {
      debugPrint('[NotificationRemoteDS] failed: ${e.message}');
    } catch (e) {
      debugPrint('[NotificationRemoteDS] unexpected: $e');
    }
  }
}