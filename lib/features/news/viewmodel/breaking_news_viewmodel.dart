import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/news_repository.dart';
import '../state/news_state.dart';

class BreakingNewsViewModel extends StateNotifier<NewsState> {
  final NewsRepository repository;

  BreakingNewsViewModel(this.repository) : super(const NewsState()) {
    fetchBreakingNews();
  }

  Future<void> fetchBreakingNews() async {
    state = NewsState.loading(state.news);

    try {
      final results = await repository.fetchBreakingNews(limit: 6);

      if (!mounted) return;

      if (results.isEmpty) {
        state = NewsState.loaded([], hasMore: false);
      } else {
        state = NewsState.loaded(results, hasMore: false);
      }
    } catch (e) {
      if (!mounted) return;
      state = NewsState.error("Failed to load breaking news", currentNews: []);
    }
  }

  void refresh() => fetchBreakingNews();
}