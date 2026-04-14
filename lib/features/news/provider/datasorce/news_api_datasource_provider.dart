

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../datasorce/remote/news_api_datasource.dart';
import '../../datasorce/remote/news_api_datasource_impl.dart';


final newsApiDatasourceProvider = Provider<NewsApiDatasource>((ref) {
  return NewsApiDatasourceImpl(
    apiKey: dotenv.env['NEWS_API_KEY'] ?? '',
    baseUrl: dotenv.env['BASE_URL'] ?? '',
  );
});