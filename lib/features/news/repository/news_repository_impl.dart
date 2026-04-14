import '../../../core/error/app_exception.dart';

import '../datasorce/firestore/news_firebase_datasource.dart';
import '../datasorce/remote/news_api_datasource.dart';
import '../model/news_model.dart';
import 'news_repository.dart';

class NewsRepositoryImpl extends NewsRepository {
  final NewsFirebaseDatasource _firebase;
  final NewsApiDatasource _api;

  NewsRepositoryImpl({
    required NewsFirebaseDatasource firebase,
    required NewsApiDatasource api,
  })  : _firebase = firebase,
        _api = api;
  @override
  Future<List<String>> fetchCategories({required String userRole}) async {
    if (userRole == 'admin') {
      return [
        'My Posts',
        'Technology',
        'Business',
        'Sports',
        'Science',
        'Health',
      ];
    } else {
      return [
        'My Posts',
        'All',
        'Technology',
        'Business',
        'Sports',
        'Science',
        'Health',
      ];
    }
  }

  @override
  Future<List<NewsModel>> fetchApiNews({
    String? category,
    int limit = 20,
    DateTime? startAfter,
  }) => _firebase.fetchApiNews(
    category: category,
    limit: limit,
    startAfter: startAfter,
  );

  @override
  Future<List<NewsModel>> fetchUserNews({
    String? category,
    DateTime? startAfter,
  }) => _firebase.fetchUserNews(
    category: category,
    startAfter: startAfter,
  );

  @override
  Future<List<NewsModel>> fetchMyPosts({
    required String userId,
    DateTime? startAfter,
  }) => _firebase.fetchMyPosts(userId: userId, startAfter: startAfter);

  @override
  Future<List<NewsModel>> fetchAllNews({DateTime? startAfter}) async {
    final categories = [
      'Technology', 'Business', 'Sports', 'Science', 'Health',
    ];

    final apiNewsFutures = categories.map(
          (cat) => fetchApiNews(
        category: cat,
        limit: 20,
        startAfter: startAfter,
      ),
    );

    final allUserNewsFuture = fetchUserNews(startAfter: startAfter);

    final results = await Future.wait([
      ...apiNewsFutures,
      allUserNewsFuture,
    ]);

    final List<NewsModel> combined = [];
    for (int i = 0; i < categories.length; i++) {
      combined.addAll(results[i]);
    }
    combined.addAll(results[categories.length]);

    final seen = <String>{};
    final unique = combined.where((n) => seen.add(n.newsId)).toList();
    unique.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return unique;
  }

  @override
  Future<void> saveApiNews({
    required List<NewsModel> newsList,
    required String currentUserRole,
  }) async {
    if (currentUserRole != 'admin') {
      throw const PermissionException('Sync is for admins only.');
    }
    await _firebase.saveApiNews(
      newsList: newsList,
      currentUserRole: currentUserRole,
    );
  }

  @override
  Future<void> syncCategoryFromApi({
    required String category,
    required String currentUserRole,
    int limit = 20,
    int page = 1,
  }) async {
    if (currentUserRole != 'admin') {
      throw const PermissionException('Sync is for admins only.');
    }

    final apiNews = await _api.fetchNews(
      category: category,
      limit: limit,
      page: page,
    );

    if (apiNews.isEmpty) return;

    await saveApiNews(
      newsList: apiNews,
      currentUserRole: currentUserRole,
    );
  }

  @override
  Future<void> publishNews({
    required String userId,
    required String title,
    required String des,
    required String imageUrl,
    required String category,
    bool isBreaking = false,
  }) => _firebase.publishNews(
    userId: userId,
    title: title,
    des: des,
    imageUrl: imageUrl,
    category: category,
    isBreaking: isBreaking,
  );

  @override
  Future<List<NewsModel>> fetchBreakingNews({int limit = 6}) =>
      _firebase.fetchBreakingNews(limit: limit);

  @override
  Future<List<NewsModel>> searchNews({
    String? category,
    required String query,
  }) => _firebase.searchNews(category: category, query: query);

  @override
  Future<void> deleteNews({
    required String newsId,
    required String userId,
  }) => _firebase.deleteNews(newsId: newsId, userId: userId);

  @override
  Future<List<NewsModel>> getNewsByIds(List<String> ids) =>
      _firebase.getNewsByIds(ids);
}