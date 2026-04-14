import '../../model/news_model.dart';

abstract class NewsFirebaseDatasource {
  Future<List<NewsModel>> fetchApiNews({
    String? category,
    int limit = 20,
    DateTime? startAfter,
  });

  Future<List<NewsModel>> fetchUserNews({
    String? category,
    DateTime? startAfter,
  });

  Future<List<NewsModel>> fetchMyPosts({
    required String userId,
    DateTime? startAfter,
  });

  Future<void> saveApiNews({
    required List<NewsModel> newsList,
    required String currentUserRole,
  });

  Future<void> publishNews({
    required String userId,
    required String title,
    required String des,
    required String imageUrl,
    required String category,
    bool isBreaking = false,
  });

  Future<List<NewsModel>> fetchBreakingNews({int limit = 6});

  Future<List<NewsModel>> searchNews({
    String? category,
    required String query,
  });

  Future<void> deleteNews({
    required String newsId,
    required String userId,
  });

  Future<List<NewsModel>> getNewsByIds(List<String> ids);
}