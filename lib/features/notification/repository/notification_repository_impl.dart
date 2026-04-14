
import '../datasources/firebase/notification_firestore_datasource.dart';
import '../datasources/remote/notification_remote_datasource.dart';
import '../model/notification_model.dart';
import 'notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationFirestoreDataSource _firestoreDataSource;
  final NotificationRemoteDataSource _remoteDataSource;

  NotificationRepositoryImpl({
    required NotificationFirestoreDataSource firestoreDataSource,
    required NotificationRemoteDataSource remoteDataSource,
  })  : _firestoreDataSource = firestoreDataSource,
        _remoteDataSource = remoteDataSource;

  // ── Firestore ──────────────────────────────────────────────────────────────

  @override
  Stream<List<NotificationModel>> watchNotifications(String userId) =>
      _firestoreDataSource.watchNotifications(userId);

  @override
  Stream<int> watchUnreadCount(String userId) =>
      _firestoreDataSource.watchUnreadCount(userId);

  @override
  Future<void> markAsRead(String notificationId) =>
      _firestoreDataSource.markAsRead(notificationId);

  @override
  Future<void> markAllAsRead(String userId) =>
      _firestoreDataSource.markAllAsRead(userId);

  // ── Backend ────────────────────────────────────────────────────────────────

  @override
  Future<void> sendLikeNotification({
    required String newsId,
    required String newsTitle,
    required String newsImageUrl,
    required String authorId,
    required String senderId,
    required String senderUsername,
    required int currentLikesCount,
  }) =>
      _remoteDataSource.sendLikeNotification(
        newsId: newsId,
        newsTitle: newsTitle,
        newsImageUrl: newsImageUrl,
        authorId: authorId,
        senderId: senderId,
        senderUsername: senderUsername,
        currentLikesCount: currentLikesCount,
      );
}