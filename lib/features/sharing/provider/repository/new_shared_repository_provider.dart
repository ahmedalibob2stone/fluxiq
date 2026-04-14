
  import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/provider/shared_service_provider.dart';
import '../../repository/new_sharing_repository.dart';
  import '../../repository/news_sharing_repository_impl.dart';


  import '../datasorce/share_local_datasource_provider.dart';
import '../datasorce/share_remote_datasource_provider.dart';


  final shareRepositoryProvider = Provider<ShareRepository>((ref) {
    final remote = ref.read(shareRemoteDatasourceProvider);
    final local  = ref.read(shareLocalDatasourceProvider);
    final service = ref.read(shareServiceProvider);

    return ShareRepositoryImpl(remote, local, service);
  });