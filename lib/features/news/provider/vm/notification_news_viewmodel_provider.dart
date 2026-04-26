

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/notification_news_state.dart';
import '../../viewmodel/notification_news_viewmodel.dart';
import '../repository/repository_provider.dart';




final notificationNewsProvider = StateNotifierProvider.autoDispose
    .family<NotificationNewsViewModel, NotificationNewsState, String>(
      (ref, newsId) {
    final repository = ref.watch(newsRepositoryProvider);
    return NotificationNewsViewModel(repository);
  },
);