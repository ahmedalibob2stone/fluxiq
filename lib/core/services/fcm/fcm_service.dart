  import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
  import 'fcm_token_service.dart';
  import 'fcm_message_handler.dart';
  import 'local_notification_service.dart';

  class FcmService {
    final FcmTokenService _tokenService;
    final LocalNotificationService _localNotificationService;
    final FcmMessageHandler _messageHandler;
    final FirebaseMessaging _messaging;
    final FirebaseAuth _auth;

    bool _initialized = false;

    FcmService({
      required FcmTokenService tokenService,
      required LocalNotificationService localNotificationService,
      required FcmMessageHandler messageHandler,
      required FirebaseMessaging messaging,
      required FirebaseAuth auth,
    })  : _tokenService = tokenService,
          _localNotificationService = localNotificationService,
          _messageHandler = messageHandler,
          _messaging = messaging,
          _auth = auth;

    Future<void> initialize() async {
      if (_initialized) return;
      _initialized = true;

      await _messaging.requestPermission(alert: true, badge: true, sound: true);
      await _localNotificationService.initialize();
      await _messaging.setForegroundNotificationPresentationOptions(
        alert: false, badge: true, sound: false,
      );

      _messaging.onTokenRefresh.listen((newToken) {
        final uid = _auth.currentUser?.uid;
        if (uid != null) {
          _tokenService.updateToken(uid, newToken);
        }
      });


      FirebaseMessaging.onMessage.listen(_messageHandler.handleForegroundMessage);
    }
  }