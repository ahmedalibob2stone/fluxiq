import 'package:firebase_messaging/firebase_messaging.dart';
import 'local_notification_service.dart';

class FcmMessageHandler {
  final LocalNotificationService _notificationService;

  const FcmMessageHandler({
    required LocalNotificationService notificationService,
  }) : _notificationService = notificationService;

  void handleForegroundMessage(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;

    final String type    = message.data['type']        as String? ?? '';
    final String? imageUrl = message.data['newsImageUrl'] as String?;
    final String? newsId   = message.data['newsId']       as String?;
    final int uniqueId = DateTime.now().millisecondsSinceEpoch % 2147483647;

    _notificationService.show(
      id:          uniqueId,
      title:       notification.title ?? '',
      body:        notification.body  ?? '',
      channelId:   _notificationService.resolveChannelId(type),
      channelName: _notificationService.resolveChannelName(type),
      type:        type,
      imageUrl:    imageUrl,
      payload:     newsId,
    );
  }
}