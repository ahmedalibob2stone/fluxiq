import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/provider/dependency_provider.dart';
import '../../datasource/remote/share_remote_datasource.dart';
import '../../datasource/remote/share_remote_datasource_impl.dart';


final shareRemoteDatasourceProvider = Provider<ShareRemoteDatasource>((ref) {
  final firestore = ref.read(firebaseFirestoreProvider);
  return ShareRemoteDatasourceImpl(firestore);
});