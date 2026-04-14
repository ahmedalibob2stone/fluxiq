import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/constants.dart';
import '../../core/utills/helpers/generate_new_id.dart';
import '../../model/news_model.dart';
import 'news_api_datasource.dart';

class NewsApiDatasourceImpl implements NewsApiDatasource {
  final String apiKey;
  final String baseUrl;
  final AppConstants appConstants;
  final http.Client client;

  NewsApiDatasourceImpl({
    required this.apiKey,
    required this.baseUrl,
    AppConstants? appConstants,
    http.Client? client,
  })  : client = client ?? http.Client(),
        appConstants = appConstants ?? AppConstants();

  @override
  Future<List<NewsModel>> fetchNews({
    String? category,
    int limit = 20,
    int page = 1,
  }) async {
    final uri = Uri.parse(
      '$baseUrl?category=${category?.toLowerCase() ?? 'general'}'
          '&pageSize=$limit'
          '&page=$page'
          '&apiKey=$apiKey',
    );

    final res = await client.get(uri);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      final List articles = data['articles'];

      return articles.map((json) {
        final url = json['url'] ?? '';

        return NewsModel(
          newsId: generateNewsId(url),
          title: json['title'] ?? '',
          imageUrl: json['urlToImage'] ?? '',
          category: category ?? 'General',
          des: json['description'] ?? '',
          createdAt:
          DateTime.tryParse(json['publishedAt'] ?? '') ?? DateTime.now(),
          isBreaking: false,
          userId: null,
          isUserPost: false,
          sourceUrl: url,
          viewsCount: 0,
          likesCount: 0,
          authorRole: 'admin',
          source: 'api',
        );
      }).toList();
    } else {
      throw Exception('Failed to fetch news: ${res.statusCode}');
    }
  }

  @override
  Future<List<NewsModel>> searchNews({
    required String query,
    String? category,
    int page = 1,
    int limit = 20,
  }) async {
    final uri = Uri.parse(
      'https://newsapi.org/v2/everything'
          '?q=$query'
          '${category != null ? '&category=${category.toLowerCase()}' : ''}'
          '&pageSize=$limit'
          '&page=$page'
          '&apiKey=$apiKey',
    );

    final res = await client.get(uri);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      final List articles = data['articles'];

      return articles.map((json) {
        final url = json['url'] ?? '';

        return NewsModel(
          newsId: generateNewsId(url),
          title: json['title'] ?? '',
          imageUrl: json['urlToImage'] ?? '',
          category: category ?? 'General',
          des: json['description'] ?? '',
          createdAt:
          DateTime.tryParse(json['publishedAt'] ?? '') ?? DateTime.now(),
          isBreaking: false,
          userId: null,
          isUserPost: false,
          sourceUrl: url,
          viewsCount: 0,
          likesCount: 0,
        );
      }).toList();
    } else {
      throw Exception('Failed to search news: ${res.statusCode}');
    }
  }
}