
import '../model/notification_model.dart';

abstract class NotificationRepository {
  Stream<List<NotificationModel>> watchNotifications(String userId);
  Stream<int> watchUnreadCount(String userId);
  Future<void> markAsRead(String notificationId);
  Future<void> markAllAsRead(String userId);

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