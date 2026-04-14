import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/error/firestore_error_handler.dart';
import '../../model/news_view_model.dart';
import 'views_remote_datasource.dart';

class ViewsRemoteDatasourceImpl implements ViewsRemoteDatasource {
  final FirebaseFirestore _db;

  ViewsRemoteDatasourceImpl(this._db);


  Future<void> pushView({
    required String newsId,
    required String userId,
    Map<String, dynamic>? locationData,
  }) async {
    final newsRef = _db.collection('news').doc(newsId);
    final viewRef = newsRef.collection('views').doc(userId);

    final viewData = {
      "ip": locationData?['ip'] ?? '0.0.0.0',
      "country": locationData?['country'] ?? 'Unknown',
      "city": locationData?['city'] ?? 'Unknown',
      "viewedAt": FieldValue.serverTimestamp(),
    };

    final batch = _db.batch();
    batch.set(viewRef, viewData, SetOptions(merge: true));
    batch.set(
      newsRef,
      {"viewsCount": FieldValue.increment(1)},
      SetOptions(merge: true),
    );

    await batch.commit();
  }

  @override
  Stream<int> newsViewsStream(String newsId) {
    return _db
        .collection('news')
        .doc(newsId)
        .snapshots(includeMetadataChanges: true)
        .map((doc) {
      final data = doc.data();
      if (data == null) return 0;
      return (data['viewsCount'] ?? 0) as int;
    })
        .handleError((error) {
      throw ErrorHandler.handle(error);
    });
  }


  @override
  Future<List<NewsViewModelModel>> fetchViews(String newsId) async {
    try {
      final snap = await _db
          .collection('news')
          .doc(newsId)
          .collection('views')
          .orderBy('viewedAt', descending: true)
          .get();

      return snap.docs.map((doc) {
        final data = doc.data();
        if (data['viewedAt'] is Timestamp) {
          data['viewedAt'] =
              (data['viewedAt'] as Timestamp).toDate().toIso8601String();
        }
        return NewsViewModelModel.fromJson(data);
      }).toList();
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}