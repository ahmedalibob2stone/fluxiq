import '../model/news_view_model.dart';

abstract class NewsViewsRepository {
  Future<void> addView({required String newsId, required String userId});

  Stream<int> newsViewsStream(String newsId);

  Future<List<NewsViewModelModel>> fetchViews(String newsId);
  Future<void> syncPendingViews();
}