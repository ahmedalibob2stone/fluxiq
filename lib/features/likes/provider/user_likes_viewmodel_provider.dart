import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/provider/current_user_id_provider.dart';
import '../state/likes_state.dart';
import '../state/user_likes_history_state.dart';
import '../viewmodel/user_likes_history_viewmodel.dart';
import 'likes_repository_provider.dart';
final userLikesHistoryProvider = StateNotifierProvider.autoDispose<UserLikesHistoryViewModel, UserLikesHistoryState>(
      (ref) {
    final repository = ref.watch(likesRepositoryProvider);
    final userId = ref.watch(currentUserIdProvider);

    if (userId == null) {
      throw Exception('User not logged in');
    }

    return UserLikesHistoryViewModel(
      repository: repository,
      currentUserId: userId,
    );
  },
);