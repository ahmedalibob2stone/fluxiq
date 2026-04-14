import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/provider/current_user_provider.dart';
import '../../notification/providers/repository/notification_repository_provider.dart';
import '../state/likes_state.dart';
import '../viewmodel/likes_view_model.dart';
import 'likes_repository_provider.dart';

final likesViewModelProvider = StateNotifierProvider.autoDispose
    .family<LikesViewModel, LikesState, String>((ref, newsId) {
  final user = ref.watch(currentUserProvider);
  if (user == null) {
    throw Exception('User not logged in');
  }
  return LikesViewModel(
    repository: ref.read(likesRepositoryProvider),
    newsId: newsId,
    userId: user.uid,
    email: user.email,
    name: user.name, notificationRepository:ref.read(notificationRepositoryProvider),
  );
});
