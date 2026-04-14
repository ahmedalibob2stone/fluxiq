import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxiq/features/views/core/extensions/number_formatter_view_extension.dart';
import '../../../core/error/app_exception.dart';
import '../repository/new_views_repository.dart';
import '../state/new_views_state.dart';

class NewsViewsViewModel extends StateNotifier<NewsViewsState> {
  final NewsViewsRepository repository;
  final String userId;

  StreamSubscription<int>? _viewsSub;

  NewsViewsViewModel({
    required this.repository,
    required this.userId,
  }) : super(NewsViewsState.initial());

  void initialize(String newsId) {
    _viewsSub?.cancel();
    _viewsSub = repository.newsViewsStream(newsId).listen(
          (count) {
        if (!mounted) return;
        state = state.copyWith(
          countView: count,
          status: NewsViewsStatus.loaded,
        );
      },
      onError: (error) {
        if (!mounted) return;
        if (error is AppException) {
          state = state.copyWith(
            status: NewsViewsStatus.error,
            errorMessage: error.message,
          );
        }
      },
    );
  }

  Future<void> addView({required String newsId}) async {
    if (state.viewRecorded) return;

    try {
      await repository.addView(newsId: newsId, userId: userId);

      if (!mounted) return;
      state = state.copyWith(
        status: NewsViewsStatus.loaded,
        viewRecorded: true,
        countView: state.countView + 1,
      );
    } on AppException catch (e) {
      if (!mounted) return;
      state = state.copyWith(
        status: NewsViewsStatus.error,
        errorMessage: e.message,
      );
    }
  }

  String get formattedViews {
    return state.countView.toCompactFormatForViews();
  }

  @override
  void dispose() {
    _viewsSub?.cancel();
    super.dispose();
  }
}