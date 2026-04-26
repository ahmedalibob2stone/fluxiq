
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/provider/current_user_id_provider.dart';
import '../../state/notification_state.dart';
import '../../viewmodels/notification_viewmodel.dart';
import '../repository/notification_repository_provider.dart';

final notificationVmProvider =
StateNotifierProvider<NotificationViewModel, NotificationState>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  final repository = ref.watch(notificationRepositoryProvider);

  return NotificationViewModel(
    repository: repository,
    userId: userId ?? '',
  );
});