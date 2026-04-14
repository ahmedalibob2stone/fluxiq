import '../../model/cached_view_model.dart';


abstract class ViewsLocalDatasource {
  Future<bool> isNewsViewed(String newsId);
  Future<void> markNewsAsViewed(String newsId);

  Future<void> savePendingView(CachedViewModel view);
  Future<List<CachedViewModel>> getPendingViews();
  Future<void> removePendingView({
    required String newsId,
    required String userId,
  });
}


