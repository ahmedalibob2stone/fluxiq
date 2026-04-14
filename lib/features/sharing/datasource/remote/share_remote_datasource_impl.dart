import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/pending_share_model.dart';
import 'share_remote_datasource.dart';

class ShareRemoteDatasourceImpl implements ShareRemoteDatasource {
  final FirebaseFirestore _firestore;

  ShareRemoteDatasourceImpl(this._firestore);

  @override
  Future<void> saveShareToFirestore(CacheShareModel share) async {
    final newsRef = _firestore.collection('news').doc(share.newsId);
    final userShareRef = newsRef.collection('shares').doc(share.userId);
    final detailRef =
    userShareRef.collection('shareDetails').doc(share.shareId);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(userShareRef);

      if (!snapshot.exists) {
        transaction.set(userShareRef, {'totalShares': 1});
      } else {
        transaction.update(userShareRef, {
          'totalShares': FieldValue.increment(1),
        });
      }

      transaction.update(newsRef, {
        'totalShares': FieldValue.increment(1),
      });

      transaction.set(detailRef, {
        'platform': share.platform,
        'sharedAt': Timestamp.fromDate(share.sharedAt),
      });
    });
  }
}