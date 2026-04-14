import '../../model/news_model.dart';

abstract class NewsApiDatasource {
  Future<List<NewsModel>> fetchNews({
    String? category,
    int limit = 20,
    int page = 1,
  });

  Future<List<NewsModel>> searchNews({
    required String query,
    String? category,
    int page = 1,
    int limit = 20,
  });
}