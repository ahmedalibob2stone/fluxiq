
import '../../model/notification_model.dart';

abstract class NotificationFirestoreDataSource {
  Stream<List<NotificationModel>> watchNotifications(String userId);

  Stream<int> watchUnreadCount(String userId);

  Future<void> markAsRead(String notificationId);

  Future<void> markAllAsRead(String userId);
}