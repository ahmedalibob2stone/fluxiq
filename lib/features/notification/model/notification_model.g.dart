// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationModelImpl _$$NotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationModelImpl(
      id: json['id'] as String,
      recipientUserId: json['recipientUserId'] as String,
      senderUserId: json['senderUserId'] as String,
      senderUsername: json['senderUsername'] as String,
      type: json['type'] as String,
      newsId: json['newsId'] as String,
      newsTitle: json['newsTitle'] as String,
      newsImageUrl: json['newsImageUrl'] as String,
      isRead: json['isRead'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$NotificationModelImplToJson(
        _$NotificationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recipientUserId': instance.recipientUserId,
      'senderUserId': instance.senderUserId,
      'senderUsername': instance.senderUsername,
      'type': instance.type,
      'newsId': instance.newsId,
      'newsTitle': instance.newsTitle,
      'newsImageUrl': instance.newsImageUrl,
      'isRead': instance.isRead,
      'createdAt': instance.createdAt.toIso8601String(),
    };
