
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('[FCM Background] ${message.notification?.title}');
}

class FcmService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();
  final FirebaseFirestore _firestore;
  final String? _userId;

  FcmService({
    required FirebaseFirestore firestore,
    required String? userId,
  })  : _firestore = firestore,
        _userId = userId;

  Future<void> initialize() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    const androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    await _localNotifications.initialize(
      const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
    );

    const androidChannel = AndroidNotificationChannel(
      'breaking_news_channel',
      'Breaking News',
      importance: Importance.max,
      playSound: true,
    );
    await _localNotifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);

    await _messaging.subscribeToTopic('breaking_news');

    await _saveToken();

    _messaging.onTokenRefresh.listen(_updateToken);

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

  }

  Future<void> _saveToken() async {
    if (_userId == null) return;
    final token = await _messaging.getToken();
    if (token == null) return;
    await _updateToken(token);
  }

  Future<void> _updateToken(String token) async {
    if (_userId == null) return;
    try {
      await _firestore.collection('users').doc(_userId).update({
        'fcmToken': token,
        'fcmTokenUpdatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('[FcmService] failed to update token: $e');
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;

    _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'breaking_news_channel',
          'Breaking News',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }
}


