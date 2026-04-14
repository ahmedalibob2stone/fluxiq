import '../model/like_model.dart';

abstract class LikesRepository {
  Future<void> toggleLike({
    required String newsId,
    required String userId,
    required LikeModel like,
    required bool isCurrentlyLiked,
  });

  Stream<bool> isLiked({
    required String newsId,
    required String userId,
  });

  Stream<int> likesCount(String newsId);
  Stream<List<LikeModel>> getUserLikedNews(String userId);


}
