
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import '../../../firebase_options.dart';
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final Map<String, dynamic> data = message.data;

  final String title = data['title']?.isNotEmpty == true
      ? data['title']
      : message.notification?.title ?? '';

  final String body = data['body']?.isNotEmpty == true
      ? data['body']
      : message.notification?.body ?? '';

  final String imageUrl = data['newsImageUrl'] ?? '';
  final String type     = data['type']         ?? '';
  final String newsId   = data['newsId']        ?? '';

  debugPrint('[FCM Background] title=$title | body=$body | image=$imageUrl');

  if (title.isEmpty && body.isEmpty) {
    debugPrint('[FCM Background] empty title & body — skip');
    return;
  }

  final plugin = FlutterLocalNotificationsPlugin();

  const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  await plugin.initialize(
    const InitializationSettings(android: androidSettings),
  );

  final androidPlugin = plugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();

  if (androidPlugin != null) {
    await androidPlugin.createNotificationChannel(
      const AndroidNotificationChannel(
        'breaking_news_channel',
        'Breaking News',
        description: 'Urgent breaking news alerts',
        importance: Importance.max,
        playSound: true,
        enableVibration: true,
        sound: RawResourceAndroidNotificationSound('breaking_news_sound'),
      ),
    );
    await androidPlugin.createNotificationChannel(
      const AndroidNotificationChannel(
        'likes_channel',
        'Likes',
        description: 'Notifications when someone likes your article',
        importance: Importance.high,
        playSound: true,
        enableVibration: true,
      ),
    );
    await androidPlugin.createNotificationChannel(
      const AndroidNotificationChannel(
        'milestones_channel',
        'Milestones',
        description: 'Milestone achievements for your articles',
        importance: Importance.high,
        playSound: true,
        enableVibration: true,
      ),
    );
  }

  ByteArrayAndroidBitmap? imageBitmap;
  if (imageUrl.isNotEmpty) {
    try {
      final response = await http
          .get(Uri.parse(imageUrl))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        imageBitmap = ByteArrayAndroidBitmap(response.bodyBytes);
        debugPrint('[FCM Background] image loaded ');
      } else {
        debugPrint('[FCM Background] image HTTP ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('[FCM Background] image load failed: $e');
    }
  }

  final bool isBreaking = type == 'breaking_news';

  final String resolvedChannelId = isBreaking
      ? 'breaking_news_channel'
      : type == 'milestone'
      ? 'milestones_channel'
      : 'likes_channel';

  final String resolvedChannelName = isBreaking
      ? 'Breaking News'
      : type == 'milestone'
      ? 'Milestones'
      : 'Likes';

  final int notifId =
      DateTime.now().millisecondsSinceEpoch % 2147483647;

  await plugin.show(
    notifId,
    title,
    body,
    NotificationDetails(
      android: AndroidNotificationDetails(
        resolvedChannelId,
        resolvedChannelName,
        importance: isBreaking ? Importance.max : Importance.high,
        priority: isBreaking ? Priority.max : Priority.high,
        playSound: true,
        enableVibration: true,
        sound: isBreaking
            ? const RawResourceAndroidNotificationSound('breaking_news_sound')
            : null,
        largeIcon: imageBitmap,
        styleInformation: imageBitmap != null
            ? BigPictureStyleInformation(
          imageBitmap,
          hideExpandedLargeIcon: false,
          contentTitle: title,
          summaryText: body,
        )
            : BigTextStyleInformation(body),
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        badgeNumber: 1,
      ),
    ),
    payload: newsId,
  );

  debugPrint('[FCM Background] notification shown Id=$notifId');
}



