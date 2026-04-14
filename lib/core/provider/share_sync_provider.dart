import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/sharing/provider/repository/new_shared_repository_provider.dart';

final shareSyncProvider = StreamProvider<void>((ref) {
  final repository = ref.watch(shareRepositoryProvider);

  return Connectivity().onConnectivityChanged.asyncMap((results) async {
    final hasConnection =
    results.any((result) => result != ConnectivityResult.none);
    if (hasConnection) {
      await repository.syncPendingShares();
    }
  });
});

final currentUserIdProvider = Provider<String>((ref) {
  throw UnimplementedError('Override currentUserIdProvider');
});