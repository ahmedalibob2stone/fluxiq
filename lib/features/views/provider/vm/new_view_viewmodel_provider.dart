

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/provider/current_user_id_provider.dart';
import '../../state/new_views_state.dart';
import '../../viewmodel/new_views_viewmodel.dart';
import '../repository/new_view_repository_provider.dart';
final newsViewsProvider =
StateNotifierProvider.autoDispose.family<NewsViewsViewModel, NewsViewsState, String>(
      (ref, newsId) {
        final userId = ref.watch(currentUserIdProvider);
        final repository = ref.watch(newsViewsRepositoryProvider);

    return NewsViewsViewModel(
      repository: repository,
      userId: userId ?? "anonymous",
    );
  },
);