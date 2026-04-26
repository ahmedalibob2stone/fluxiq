// features/news/presentation/viewmodel/notification_news_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/error/app_exception.dart';

import '../repository/news_repository.dart';
import '../state/notification_news_state.dart';

class NotificationNewsViewModel
    extends StateNotifier<NotificationNewsState> {
  final NewsRepository _repository;

  NotificationNewsViewModel(this._repository)
      : super(NotificationNewsState.initial());

  Future<void> loadById(String newsId) async {
    state = NotificationNewsState.loading();

    try {
      final results = await _repository.getNewsByIds([newsId]);

      if (!mounted) return;

      if (results.isNotEmpty) {
        state = NotificationNewsState.loaded(results.first);
      } else {
        state = NotificationNewsState.error('News not found.');
      }
    } on AppException catch (e) {
      if (!mounted) return;
      state = NotificationNewsState.error(e.message);
    } catch (_) {
      if (!mounted) return;
      state = NotificationNewsState.error(
        'Failed to load news. Please try again.',
      );
    }
  }
}