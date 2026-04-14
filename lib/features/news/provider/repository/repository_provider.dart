import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../repository/news_repository.dart';
import '../../repository/news_repository_impl.dart';
import '../datasorce/news_api_datasource_provider.dart';
import '../datasorce/news_firebase_provider.dart';

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  final firebase = ref.read(newsFirebaseDatasourceProvider);
  final api = ref.read(newsApiDatasourceProvider);

  return NewsRepositoryImpl(
    firebase: firebase,
    api: api,
  );
});