import '../../model/pending_share_model.dart';

abstract class ShareRemoteDatasource {
  Future<void> saveShareToFirestore(CacheShareModel share);
}