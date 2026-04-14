import '../../model/pending_share_model.dart';

abstract class ShareLocalDatasource {
  Future<void> addPendingShare(CacheShareModel share);
  List<CacheShareModel> getPendingShares();
  Future<void> removePendingShare(String shareId);
  int getShareCount(String newsId, String userId);
  Future<void> incrementShareCount(String newsId, String userId);
}
