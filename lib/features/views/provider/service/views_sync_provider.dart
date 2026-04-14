import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/provider/connectivity_datasorce_provider.dart';
import '../repository/new_view_repository_provider.dart';

final viewsSyncProvider = Provider<void>((ref) {
  final repository   = ref.read(newsViewsRepositoryProvider);
  final connectivity = ref.read(connectivityDatasourceProvider);

  repository.syncPendingViews();

  connectivity.connectivityStream.listen((isOnline) {
    if (isOnline) {
      repository.syncPendingViews();
    }
  });
});