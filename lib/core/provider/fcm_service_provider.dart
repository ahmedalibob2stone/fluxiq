import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/fcm_token_service.dart';
import 'current_user_id_provider.dart';

final fcmServiceProvider = Provider<FcmService>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  return FcmService(
    firestore: FirebaseFirestore.instance,
    userId: userId,
  );
});