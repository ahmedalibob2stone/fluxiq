import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import '../interfaces/i_local_notification_service.dart';

const String _breakingNewsChannelId = 'breaking_news_channel';
const String _likesChannelId        = 'likes_channel';
const String _milestonesChannelId   = 'milestones_channel';

class LocalNotificationService implements ILocalNotificationService {
  final FlutterLocalNotificationsPlugin _plugin;

  const LocalNotificationService({
    required FlutterLocalNotificationsPlugin plugin,
  }) : _plugin = plugin;


  @override
  Future<void> initialize() async {
    const androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    await _plugin.initialize(
      const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
      onDidReceiveNotificationResponse: _onNotificationTapped,
      onDidReceiveBackgroundNotificationResponse: _onBackgroundNotificationTapped,
    );
  }

  @override
  Future<void> show({
    required int id,
    required String title,
    required String body,
    required String channelId,
    required String channelName,
    required String type,
    String? imageUrl,
    String? payload,
  }) async {
    final imageBitmap = await _loadImageBitmap(imageUrl);
    final isBreaking  = type == 'breaking_news';

    await _plugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          channelName,
          importance:      isBreaking ? Importance.max  : Importance.high,
          priority:        isBreaking ? Priority.max    : Priority.high,
          playSound:       true,
          enableVibration: true,
          sound:
          isBreaking
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
      payload: payload,
    );
  }

  Future<ByteArrayAndroidBitmap?> _loadImageBitmap(String? url) async {
    if (url == null || url.isEmpty) return null;
    try {
      final response =
      await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        return ByteArrayAndroidBitmap(response.bodyBytes);
      }
    } catch (e) {
      debugPrint('[LocalNotificationService] Image load failed: $e');
    }
    return null;
  }

  String resolveChannelId(String type) {
    switch (type) {
      case 'breaking_news': return _breakingNewsChannelId;
      case 'milestone':     return _milestonesChannelId;
      default:              return _likesChannelId;
    }
  }

  String resolveChannelName(String type) {
    switch (type) {
      case 'breaking_news': return 'Breaking News';
      case 'milestone':     return 'Milestones';
      default:              return 'Likes';
    }
  }

  static void _onNotificationTapped(NotificationResponse response) {
    final newsId = response.payload;
    if (newsId == null || newsId.isEmpty) return;
    debugPrint('[LocalNotificationService] Tapped — newsId: $newsId');
  }

  @pragma('vm:entry-point')
  static void _onBackgroundNotificationTapped(NotificationResponse response) {
    debugPrint('[LocalNotificationService] Background tap: ${response.payload}');
  }
}