
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/notification_model.dart';
import 'notification_firestore_datasource.dart';

class NotificationFirestoreDataSourceImpl
    implements NotificationFirestoreDataSource {
  final FirebaseFirestore _firestore;

  NotificationFirestoreDataSourceImpl(this._firestore);

  static const String _collection = 'notifications';

  @override
  Stream<List<NotificationModel>> watchNotifications(String userId) {
    return _firestore
        .collection(_collection)
        .where('recipientUserId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .limit(50)
        .snapshots()
        .map(
          (snap) => snap.docs
          .map(NotificationModel.fromFirestore)
          .toList(),
    );
  }

  @override
  Stream<int> watchUnreadCount(String userId) {
    return _firestore
        .collection(_collection)
        .where('recipientUserId', isEqualTo: userId)
        .where('isRead', isEqualTo: false)
        .snapshots()
        .map((snap) => snap.size);
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await _firestore
        .collection(_collection)
        .doc(notificationId)
        .update({'isRead': true});
  }

  @override
  Future<void> markAllAsRead(String userId) async {
    final batch = _firestore.batch();

    final snap = await _firestore
        .collection(_collection)
        .where('recipientUserId', isEqualTo: userId)
        .where('isRead', isEqualTo: false)
        .get();

    for (final doc in snap.docs) {
      batch.update(doc.reference, {'isRead': true});
    }

    await batch.commit();
  }
}