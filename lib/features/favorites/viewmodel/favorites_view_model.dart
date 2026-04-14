import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/app_exception.dart';
import '../../news/model/news_model.dart';
import '../model/favorite_model.dart';
import '../repository/favorites_repository.dart';
import '../state/favorites_state.dart';

class FavoritesViewModel extends StateNotifier<FavoritesState> {
  final FavoritesRepository repository;
  final String userId;

  FavoritesViewModel(this.repository, this.userId)
      : super(FavoritesState.initial());

  Future<void> loadFavorites() async {
    state = state.copyWith(loading: true);

    try {
      final favNews = await repository.getUserFavoritesNews(userId: userId);
      state = state.copyWith(
        favorites: favNews,
        loading: false,
      );
    } on AppException catch (e) {
      state = state.copyWith(loading: false, error: e.message);
    }
  }

  Future<void> toggleFavorite(NewsModel news) async {
    final favorite = FavoriteModel(
      userId: userId,
      newsId: news.newsId,
      title: news.title,
      imageUrl: news.imageUrl,
      category: news.category,
      createdAt: DateTime.now(),
    );

    final existingIndex = state.favorites.indexWhere(
          (item) => item.newsId == favorite.newsId,
    );
    final isFav = existingIndex != -1;

    if (!isFav && state.favorites.length >= 50) {
      state = state.copyWith(
        error: "You have reached the maximum for favorites limit",
      );
      return;
    }

    final previousFavorites = List<FavoriteModel>.from(state.favorites);

    if (isFav) {
      final updated = List<FavoriteModel>.from(state.favorites)
        ..removeAt(existingIndex);
      state = state.copyWith(favorites: updated);
    } else {
      final updated = List<FavoriteModel>.from(state.favorites)
        ..insert(0, favorite);
      state = state.copyWith(favorites: updated);
    }

    try {
      await repository.toggleFavorite(
        userId: userId,
        favorite: favorite,
        isCurrentlyFavorite: isFav,
      );
    } on AppException catch (e) {
      state = state.copyWith(
        favorites: previousFavorites,
        error: e.message,
      );
    } catch (e) {
      state = state.copyWith(
        favorites: previousFavorites,
        error: 'An unexpected error occurred. Please try again',
      );
    }
  }

  bool isOwnPost(NewsModel news) {
    if (userId.isEmpty) return false;
    return news.isUserPost && news.userId == userId;
  }

  bool isFavorite(String newsId) => state.isFavorite(newsId);
}