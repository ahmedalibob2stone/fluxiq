
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String id,
    required String recipientUserId,
    required String senderUserId,
    required String senderUsername,
    required String type,
    required String newsId,
    required String newsTitle,
    required String newsImageUrl,
    required bool   isRead,
    required DateTime createdAt,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  factory NotificationModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NotificationModel(
      id:              doc.id,
      recipientUserId: data['recipientUserId']  as String? ?? '',
      senderUserId:    data['senderUserId']      as String? ?? '',
      senderUsername:  data['senderUsername']    as String? ?? '',
      type:            data['type']              as String? ?? 'like',
      newsId:          data['newsId']            as String? ?? '',
      newsTitle:       data['newsTitle']         as String? ?? '',
      newsImageUrl:    data['newsImageUrl']      as String? ?? '',
      isRead:          data['isRead']            as bool?   ?? false,
      createdAt: data['createdAt'] is Timestamp
          ? (data['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }
}