import '../model/news_view_model.dart';

enum NewsViewsStatus { initial, loading, loaded, error }

class NewsViewsState {
  final NewsViewsStatus status;
  final int countView;
  final bool viewRecorded;
  final List<NewsViewModelModel>? views;
  final String? errorMessage;

  const NewsViewsState({
    required this.status,
    required this.countView,
    this.viewRecorded = false,
    this.views,
    this.errorMessage,
  });

  NewsViewsState copyWith({
    NewsViewsStatus? status,
    int? countView,
    bool? viewRecorded,
    List<NewsViewModelModel>? views,
    String? errorMessage,
  }) {
    return NewsViewsState(
      status: status ?? this.status,
      countView: countView ?? this.countView,
      viewRecorded: viewRecorded ?? this.viewRecorded,
      views: views ?? this.views,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory NewsViewsState.initial() {
    return const NewsViewsState(
      status: NewsViewsStatus.initial,
      countView: 0,
      viewRecorded: false,
      views: null,
      errorMessage: null,
    );
  }
}