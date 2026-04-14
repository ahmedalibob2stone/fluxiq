import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/error/app_exception.dart';
import '../../../core/error/firestore_error_handler.dart';
import '../model/favorite_model.dart';
import 'favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FirebaseFirestore _db;

  FavoritesRepositoryImpl(this._db);

  CollectionReference<Map<String, dynamic>> _favoritesRef(String userId) =>
      _db.collection('users').doc(userId).collection('favorites');



  @override
  Future<void> toggleFavorite({
    required String userId,
    required FavoriteModel favorite,
    required bool isCurrentlyFavorite,
  }) async {

     final favRef = _favoritesRef(userId).doc(favorite.newsId);
     final newsRef = _db.collection('news').doc(favorite.newsId);
     final userRef = _db.collection('users').doc(userId);
     final userDoc = await userRef.get();
     final currentCount = (userDoc.data()?['favoritesCount'] ?? 0) as int;
     final batch = _db.batch();
     if (!isCurrentlyFavorite && currentCount >= 50) {
       throw const LimitExceededException(
         'You have reached the maximum for favorites limit',
       );
     }
     if (isCurrentlyFavorite) {
       batch.delete(favRef);
       batch.update(newsRef, {
         'favoritesCount': FieldValue.increment(-1),
       });
       batch.update(userRef, {
         'favoritesCount': FieldValue.increment(-1),
       });
     } else {
       batch.set(favRef, {
         'userId': userId,
         'newsId': favorite.newsId,
         'title': favorite.title,
         'imageUrl': favorite.imageUrl,
         'category': favorite.category,
         'createdAt': FieldValue.serverTimestamp(),
       });
       batch.update(newsRef, {
         'favoritesCount': FieldValue.increment(1),
       });
       batch.update(userRef, {
         'favoritesCount': FieldValue.increment(1),
       });
     }
     try{
       await batch.commit();
     }
   catch (e) {
     throw ErrorHandler.handle(e);
   }
  }


  @override
  Future<bool> isFavorite({
    required String userId,
    required String newsId,
  }) async {
    try {
      final doc = await _favoritesRef(userId).doc(newsId).get();
      return doc.exists;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }


  @override
  Future<List<FavoriteModel>> getUserFavoritesNews({
    required String userId,
  }) async {
     try{
       final favSnapshot = await _favoritesRef(userId)
           .orderBy('createdAt', descending: true)
           .get();

       return favSnapshot.docs
           .map((doc) => FavoriteModel.fromJson(doc.data()))
           .toList();
     }catch (e) {
       throw ErrorHandler.handle(e);
     }

  }
}