

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import '../interfaces/i_fcm_token_service.dart';

class FcmTokenService implements IFcmTokenService {
  final FirebaseMessaging _messaging;
  final FirebaseFirestore _firestore;

  const FcmTokenService({
    required FirebaseMessaging messaging,
    required FirebaseFirestore firestore,
  })  : _messaging = messaging,
        _firestore = firestore;

  @override
  Future<void> saveToken(String userId) async {
    final token = await _messaging.getToken();
    if (token == null) return;
    await updateToken(userId, token);
    await _messaging.subscribeToTopic('breaking_news');
    debugPrint('[FcmTokenService] Token saved & subscribed: $userId');
  }

  @override
  Future<void> updateToken(String userId, String token) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'fcmToken': token,
        'fcmTokenUpdatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('[FcmTokenService] Failed to update token: $e');
    }
  }

  @override
  Future<void> clearTokenAndUnsubscribe(String? userId) async {
    try {
      await _messaging.unsubscribeFromTopic('breaking_news');
      debugPrint('[FcmTokenService] Unsubscribed from breaking_news');

      await _messaging.deleteToken();
      debugPrint('[FcmTokenService] FCM token deleted from server');

      if (userId != null) {
        await _firestore.collection('users').doc(userId).update({
          'fcmToken': null,
          'fcmTokenUpdatedAt': FieldValue.serverTimestamp(),
        });
        debugPrint('[FcmTokenService] Token cleared from Firestore: $userId');
      }
    } catch (e) {
      debugPrint('[FcmTokenService] Failed to clear token: $e');
    }
  }
}