import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/error/firestore_error_handler.dart'; // تأكد من المسار
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

  @override
  Stream<List<NotificationModel>> watchNotifications(String userId) {
    return _firestoreDataSource
        .watchNotifications(userId)
        .handleError((Object error) {
      debugPrint('[NotificationRepo] Error watching notifications: $error');
      // تحويل خطأ Firebase إلى AppException الخاص بالنظام
      throw ErrorHandler.handleFirestore(error);
    });
  }

  @override
  Stream<int> watchUnreadCount(String userId) {
    return _firestoreDataSource
        .watchUnreadCount(userId)
        .handleError((Object error) {
      debugPrint('[NotificationRepo] Error watching unread count: $error');
      throw ErrorHandler.handleFirestore(error);
    });
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    try {
      await _firestoreDataSource.markAsRead(notificationId);
    } catch (e) {
      throw ErrorHandler.handleFirestore(e);
    }
  }

  @override
  Future<void> markAllAsRead(String userId) async {
    try {
      await _firestoreDataSource.markAllAsRead(userId);
    } catch (e) {
      throw ErrorHandler.handleFirestore(e);
    }
  }

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
    try {
      await _remoteDataSource.sendLikeNotification(
        newsId: newsId,
        newsTitle: newsTitle,
        newsImageUrl: newsImageUrl,
        authorId: authorId,
        senderId: senderId,
        senderUsername: senderUsername,
        currentLikesCount: currentLikesCount,
      );
    } catch (e) {
      // هنا الفشل صامت لأنها عملية خلفية لا تهم المستخدم مباشرة
      debugPrint('[NotificationRepo] sendLikeNotification silent fail: $e');
    }
  }
}