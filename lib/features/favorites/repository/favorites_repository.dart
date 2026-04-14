  import '../model/favorite_model.dart';
  abstract class FavoritesRepository {
    Future<void> toggleFavorite({
      required String userId,
      required FavoriteModel favorite,
      required bool isCurrentlyFavorite,
    });

    Future<bool> isFavorite({
      required String userId,
      required String newsId,
    });
    Future<List<FavoriteModel>> getUserFavoritesNews({
      required String userId,
    });
  }
