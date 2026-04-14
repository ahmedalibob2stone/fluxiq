
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/app_exception.dart';
import '../model/news_model.dart';
import '../repository/news_repository.dart';
import '../state/category_item.dart';
import '../state/news_state.dart';

class NewsViewModel extends StateNotifier<NewsState> {
  final String currentUserId;
  final String currentUserRole;
  final NewsRepository repository;

  NewsViewModel({
    required this.currentUserId,
    required this.currentUserRole,
    required this.repository,
  }) : super(const NewsState());

  List<NewsModel> _news = [];
  bool _hasMore = true;
  DateTime? _lastDate;

  final Map<String, int> _categoryApiPage = {};

  int _getApiPage(String category) {
    return _categoryApiPage[category] ?? 1;
  }

  void _incrementApiPage(String category) {
    _categoryApiPage[category] = (_categoryApiPage[category] ?? 1) + 1;
  }

  bool get isAdmin => currentUserRole == 'admin';
  bool get isUser => currentUserRole != 'admin';

  Future<List<String>> fetchCategories() async {
    try {
      return await repository.fetchCategories(userRole: currentUserRole);
    } catch (_) {
      return [];
    }
  }

  List<CategoryItem> getCategoryItems(List<String> categories) {
    return categories
        .map((name) => CategoryItem(
      displayName: name,
      value: name == 'All' ? null : name,
    ))
        .toList();
  }

  bool isOwnPost(NewsModel news) {
    if (currentUserId.isEmpty) return false;
    return news.isUserPost && news.userId == currentUserId;
  }

  void loadMoreNews({String? category, bool refresh = false}) {
    if (state.hasMore && !state.loading) {
      fetchNews(category: category, refresh: refresh);
    }
  }


  Future<void> fetchNews({String? category, bool refresh = false}) async {
    if (refresh) {
      _news.clear();
      _lastDate = null;
      _hasMore = true;
    }

    if (!_hasMore) return;

    state = NewsState.loading(List<NewsModel>.from(_news));

    try {
      final List<NewsModel> currentBatch;

      if (category == 'My Posts') {
        currentBatch = await _fetchMyPosts();
      } else if (category == null && isUser) {
        currentBatch = await _fetchAllForUser();
      } else if (isAdmin && category != null) {
        currentBatch = await _fetchCategoryForAdmin(category);
      } else {
        currentBatch = await _fetchCategoryForUser(category);
      }

      final cleanBatch = _sanitizeBatch(currentBatch);
      _news.addAll(cleanBatch);

      if (_news.isNotEmpty) {
        _lastDate = _news.last.createdAt;
      }

      _hasMore = currentBatch.isNotEmpty;

      if (!mounted) return;
      state = NewsState.loaded(
        List<NewsModel>.from(_news),
        hasMore: _hasMore,
      );
    } on AppException catch (e) {

      if (!mounted) return;
      state = NewsState.error(
        e.message,
        currentNews: List<NewsModel>.from(_news),
      );
    }
  }


  Future<List<NewsModel>> _fetchCategoryForAdmin(String category) async {
    List<NewsModel> batch = await repository.fetchApiNews(
      category: category,
      limit: 20,
      startAfter: _lastDate,
    );

    if (batch.isEmpty) {
      final page = _getApiPage(category);

      await repository.syncCategoryFromApi(
        category: category,
        currentUserRole: currentUserRole,
        limit: 20,
        page: page,
      );

      _incrementApiPage(category);

      batch = await repository.fetchApiNews(
        category: category,
        limit: 20,
        startAfter: _lastDate,
      );
    }

    return batch;
  }

  Future<List<NewsModel>> _fetchCategoryForUser(String? category) async {
    final results = await Future.wait([
      repository.fetchApiNews(
        category: category,
        limit: 20,
        startAfter: _lastDate,
      ),
      repository.fetchUserNews(
        category: category,
        startAfter: _lastDate,
      ),
    ]);

    final apiNews = results[0];
    final userNews = results[1];

    final combined = [...apiNews, ...userNews];
    combined.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return combined;
  }

  Future<List<NewsModel>> _fetchAllForUser() async {
    return await repository.fetchAllNews(
      startAfter: _lastDate,
    );
  }

  Future<List<NewsModel>> _fetchMyPosts() async {
    return await repository.fetchMyPosts(
      userId: currentUserId,
      startAfter: _lastDate,
    );
  }

  void removeNewsLocally(String newsId) {
    _news.removeWhere((item) => item.newsId == newsId);
    state = NewsState.loaded(
      List<NewsModel>.from(_news),
      hasMore: _hasMore,
    );
  }

  Future<void> refreshNews({String? category}) async {
    await fetchNews(category: category, refresh: true);
  }
  static bool _isValidImageUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    if (!uri.hasScheme || !uri.hasAuthority) return false;
    if (uri.host.isEmpty) return false;
    if (uri.scheme != 'http' && uri.scheme != 'https') return false;
    return true;
  }

  List<NewsModel> _sanitizeBatch(List<NewsModel> batch) {
    return batch.where((news) => _isValidImageUrl(news.imageUrl)).toList();
  }
}