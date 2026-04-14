import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repository/notification_repository.dart';
import '../../repository/notification_repository_impl.dart';
import '../datasorce/notification_firestore_datasource_provider.dart';
import '../datasorce/notification_remote_datasorce_provider.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepositoryImpl(
    firestoreDataSource: ref.watch(notificationFirestoreDataSourceProvider),
    remoteDataSource: ref.watch(notificationRemoteDataSourceProvider),
  );
});