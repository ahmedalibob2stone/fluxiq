// features/news/data/state/notification_news_state.dart
import '../model/news_model.dart';

enum NotificationNewsStatus { initial, loading, loaded, error }

class NotificationNewsState {
  final NotificationNewsStatus status;
  final NewsModel? news;
  final String? errorMessage;

  const NotificationNewsState({
    this.status = NotificationNewsStatus.initial,
    this.news,
    this.errorMessage,
  });

  factory NotificationNewsState.initial() =>
      const NotificationNewsState();

  factory NotificationNewsState.loading() =>
      const NotificationNewsState(status: NotificationNewsStatus.loading);

  factory NotificationNewsState.loaded(NewsModel news) =>
      NotificationNewsState(
        status: NotificationNewsStatus.loaded,
        news: news,
      );

  factory NotificationNewsState.error(String message) =>
      NotificationNewsState(
        status: NotificationNewsStatus.error,
        errorMessage: message,
      );

  bool get isLoading => status == NotificationNewsStatus.loading;
  bool get hasError => status == NotificationNewsStatus.error;
}