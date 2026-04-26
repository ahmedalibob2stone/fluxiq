import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract final class NotificationChannelService {
  static const String breakingNewsChannelId = 'breaking_news_channel';
  static const String likesChannelId = 'likes_channel';
  static const String milestonesChannelId = 'milestones_channel';

  static Future<void> register() async {
    if (!Platform.isAndroid) return;


    final androidPlugin = FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin == null) return;

    await Future.wait([
      androidPlugin.createNotificationChannel(
        const AndroidNotificationChannel(
          breakingNewsChannelId,
          'Breaking News',
          description: 'Urgent breaking news alerts',
          importance: Importance.max,
          playSound: true,
          enableVibration: true,
          sound: RawResourceAndroidNotificationSound('breaking_news_sound'),
        ),
      ),
      androidPlugin.createNotificationChannel(
        const AndroidNotificationChannel(
          likesChannelId,
          'Likes',
          description: 'Notifications when someone likes your article',
          importance: Importance.high,
          playSound: true,
          enableVibration: true,
        ),
      ),
      androidPlugin.createNotificationChannel(
        const AndroidNotificationChannel(
          milestonesChannelId,
          'Milestones',
          description: 'Milestone achievements for your articles',
          importance: Importance.high,
          playSound: true,
          enableVibration: true,
        ),
      ),
    ]);
  }}