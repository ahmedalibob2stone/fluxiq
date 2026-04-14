import '../../model/news_view_model.dart';

abstract class ViewsRemoteDatasource {
  Future<void> pushView({
    required String newsId,
    required String userId,
    Map<String, dynamic>? locationData,
  });

  Stream<int> newsViewsStream(String newsId);

  Future<List<NewsViewModelModel>> fetchViews(String newsId);
}