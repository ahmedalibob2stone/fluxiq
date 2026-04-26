
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/provider/fcm_service_provider.dart';
import '../repository/auth_repository.dart';
import '../repository/auth_repository_impl.dart';
import 'auth_remote_datasource_provider.dart';
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final firebaseDataSource = ref.watch(authFirebaseRemoteDataSourceProvider);
  final remoteDataSource   = ref.watch(authResendRemoteDataSourceProvider);
  final fcmTokenService    = ref.watch(fcmTokenServiceProvider);

  return AuthRepositoryImpl(
    firebaseDataSource: firebaseDataSource,
    remoteDataSource:   remoteDataSource,
    fcmTokenService:    fcmTokenService,  // ← جديد
  );
});