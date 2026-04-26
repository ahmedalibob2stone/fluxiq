
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/current_user_id_provider.dart';
import '../../provider/dependency_provider.dart';
import '../fcm/fcm_message_handler.dart';
import '../fcm/fcm_service.dart';
import '../fcm/fcm_token_service.dart';
import '../fcm/local_notification_service.dart';

final localNotificationsPluginProvider = Provider<FlutterLocalNotificationsPlugin>((ref) {
  return FlutterLocalNotificationsPlugin();
});

final localNotificationServiceProvider = Provider<LocalNotificationService>((ref) {
  final plugin = ref.watch(localNotificationsPluginProvider);
  return LocalNotificationService(plugin: plugin);
});

final fcmMessageHandlerProvider = Provider<FcmMessageHandler>((ref) {
  final localService = ref.watch(localNotificationServiceProvider);
  return FcmMessageHandler(notificationService: localService);
});

final fcmTokenServiceProvider = Provider<FcmTokenService>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  final messaging = ref.watch(firebaseMessagingProvider);

  return FcmTokenService(
    messaging: messaging,
    firestore: firestore,
  );
});

final fcmServiceProvider = Provider<FcmService>((ref) {
  final messaging     = ref.watch(firebaseMessagingProvider);
  final localService  = ref.watch(localNotificationServiceProvider);
  final tokenService  = ref.watch(fcmTokenServiceProvider);
  final messageHandler = ref.watch(fcmMessageHandlerProvider);

  return FcmService(
    tokenService:             tokenService,
    localNotificationService: localService,
    messageHandler:           messageHandler,
    messaging:                messaging,     auth: ref.read(firebaseAuthProvider),
  );
});