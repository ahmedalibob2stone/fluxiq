
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/auth_repository.dart';
import '../repository/auth_repository_impl.dart';
import 'auth_remote_datasource_provider.dart';
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    firebaseDataSource: ref.read(authFirebaseRemoteDataSourceProvider),
    remoteDataSource: ref.read(authResendRemoteDataSourceProvider),
  );
});