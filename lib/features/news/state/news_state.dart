import '../model/news_model.dart';

class NewsState {
  final List<NewsModel> news;
  final bool loading;
  final String? error;
  final bool hasMore;

  const NewsState({
    this.news = const [],
    this.loading = false,
    this.error,
    this.hasMore = true,
  });

  factory NewsState.initial() => const NewsState();
  factory NewsState.loading(List<NewsModel> currentNews) =>
      NewsState(news: currentNews, loading: true, hasMore: true);
  factory NewsState.loaded(List<NewsModel> news, {bool hasMore = true}) =>
      NewsState(news: news, loading: false, hasMore: hasMore);
  factory NewsState.error(String message, {List<NewsModel> currentNews = const []}) =>
      NewsState(news: currentNews, loading: false, error: message);
}
