import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/app_exception.dart';
import '../repository/news_repository.dart';
import '../state/news_state.dart';

typedef TimerFactory = Timer Function(Duration duration, void Function() callback);

class SearchNewsViewModel extends StateNotifier<NewsState> {
  SearchNewsViewModel({
    required this.repository,
    required this.currentUserId,
    Duration debounceDuration = const Duration(milliseconds: 500),
    TimerFactory timerFactory = _defaultTimerFactory,
  })  : _debounceDuration = debounceDuration,
        _timerFactory = timerFactory,
        super(const NewsState());

  final NewsRepository repository;
  final String currentUserId;

  final Duration _debounceDuration;
  final TimerFactory _timerFactory;

  Timer? _debounce;
  String _lastSearchQuery = '';

  static Timer _defaultTimerFactory(Duration d, void Function() cb) => Timer(d, cb);

  bool canDeletePost(String? newsUserId, bool isUserPost) {
    if (currentUserId.isEmpty) return false;
    return isUserPost && newsUserId == currentUserId;
  }

  void onQueryChanged(String query) {
    final cleanQuery = query.trim().toLowerCase();

    if (cleanQuery.isEmpty) {
      clearSearch();
      return;
    }

    if (cleanQuery == _lastSearchQuery) return;

    _debounce?.cancel();
    _debounce = _timerFactory(_debounceDuration, () {
      _lastSearchQuery = cleanQuery;
      _executeSearch(cleanQuery);
    });
  }

  Future<void> _executeSearch(String searchQuery) async {
    state = NewsState.loading(state.news);

    try {
      final results = await repository.searchNews(query: searchQuery);

      if (!mounted) return;

      state = NewsState.loaded(results, hasMore: false);
    } catch (e) {
      if (!mounted) return;
      if (!mounted) return;

      final message = e is AppException
          ? e.message
          : 'حدث خطأ غير متوقع، حاول مرة أخرى';

      state = NewsState.error(message, currentNews: state.news);
    }
  }

  void clearSearch() {
    _debounce?.cancel();
    _debounce = null;
    _lastSearchQuery = '';
    state = const NewsState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}