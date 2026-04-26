import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/provider/http_client_provider.dart';
import '../datasorce/remote/firebase/auth_firebase_remote_data_source.dart';
import '../datasorce/remote/firebase/auth_firebase_remote_data_source_impl.dart';

import '../../../core/provider/dependency_provider.dart';

import '../datasorce/remote/resend/auth_resend_remote_data_source.dart';
import '../datasorce/remote/resend/auth_resend_remote_data_source_impl.dart';


  final authFirebaseRemoteDataSourceProvider = Provider<AuthFirebaseRemoteDataSource>((ref) {
    return AuthFirebaseRemoteDataSourceImpl(
      auth: ref.read(firebaseAuthProvider),
      db: ref.read(firebaseFirestoreProvider),
      googleSignIn: ref.read(googleSignInProvider),
    );
  });


final authResendRemoteDataSourceProvider = Provider<AuthResendRemoteDataSource>((ref) {
  return AuthResendRemoteDataSourceImpl(
    client: ref.read(httpClientProvider),
    baseUrl: dotenv.env['RENDER_APL_KEY'] ?? '',
  );
});