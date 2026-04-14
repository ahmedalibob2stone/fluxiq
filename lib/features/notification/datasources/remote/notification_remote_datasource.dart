// lib/features/notification/data/datasource/notification_remote_datasource.dart

abstract class NotificationRemoteDataSource {
  /// يرسل إشعار إعجاب إلى الـ Backend على Render
  Future<void> sendLikeNotification({
    required String newsId,
    required String newsTitle,
    required String newsImageUrl,
    required String authorId,
    required String senderId,
    required String senderUsername,
    required int currentLikesCount,
  });
}