import '../../news/model/news_model.dart';


abstract class ShareRepository {
  Future<void> shareExternally({
    required NewsModel news,
    required String platform,
  });

  Future<void> cacheShareEvent({
    required String newsId,
    required String userId,
    required String platform,
  });

  int getLocalShareCount({
    required String newsId,
    required String userId,
  });

  Future<void> syncPendingShares();
}