import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../datasources/firebase/notification_firestore_datasource.dart';
import '../../datasources/firebase/notification_firestore_datasource_impl.dart';


final notificationFirestoreDataSourceProvider =
Provider<NotificationFirestoreDataSource>((ref) {
  return NotificationFirestoreDataSourceImpl(FirebaseFirestore.instance);
});

