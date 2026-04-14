import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/error/firestore_error_handler.dart';
import '../model/like_model.dart';
import 'likes_repository.dart';

class LikesRepositoryImpl implements LikesRepository {
  final FirebaseFirestore _firestore;

  LikesRepositoryImpl(this._firestore);

  @override
  Future<void> toggleLike({
    required String newsId,
    required String userId,
    required LikeModel like,
    required bool isCurrentlyLiked,
  }) async {
    final newsRef = _firestore.collection('news').doc(newsId);
    final likeRef = newsRef.collection('likes').doc(userId);
    final userLikeRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('likedNews')
        .doc(newsId);

    WriteBatch batch = _firestore.batch();

    if (isCurrentlyLiked) {
      batch.delete(likeRef);
      batch.delete(userLikeRef);
      batch.update(newsRef, {'likesCount': FieldValue.increment(-1)});
    } else {
      batch.set(likeRef, {
        'likedAt': FieldValue.serverTimestamp(),
        'name': like.name,
        'email': like.email,
      });

      batch.set(userLikeRef, {
        'likedAt': FieldValue.serverTimestamp(),
        'newsTitle': like.newsTitle,
        'newsDescription': like.newsDescription,
        'newsImageUrl': like.newsImageUrl,
        'newsUserId': like.newsUserId,
        'category': like.category,
      });

      batch.update(newsRef, {'likesCount': FieldValue.increment(1)});
    }

    try {
      await batch.commit();
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  @override
  Stream<bool> isLiked({
    required String newsId,
    required String userId,
  }) {
    return _firestore
        .collection('news')
        .doc(newsId)
        .collection('likes')
        .doc(userId)
        .snapshots()
        .map((snapshot) => snapshot.exists)
        .handleError((error) {
      throw ErrorHandler.handle(error);
    });
  }

  @override
  Stream<int> likesCount(String newsId) {
    return _firestore
        .collection('news')
        .doc(newsId)
        .snapshots()
        .map((snapshot) => (snapshot.data()?['likesCount'] ?? 0) as int)
        .handleError((error) {
      throw ErrorHandler.handle(error);
    });
  }

  @override
  Stream<List<LikeModel>> getUserLikedNews(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('likedNews')
        .orderBy('likedAt', descending: true)
        .snapshots()
        .map((snap) {
      return snap.docs
          .map((doc) => LikeModel.fromFirestore(doc))
          .toList();
    })
        .handleError((error) {
      throw ErrorHandler.handle(error);
    });
  }
}