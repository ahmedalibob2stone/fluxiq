import '../../news/model/news_model.dart';
import '../model/favorite_model.dart';

class FavoritesState {
  final List<FavoriteModel> favorites;
  final bool loading;
  final String? error;
  const FavoritesState({
    this.favorites = const [],
    this.loading = false,
    this.error,
  });
  List<NewsModel> get convertedNews => favorites
      .map((fav) => NewsModel(
    newsId: fav.newsId,
    title: fav.title,
    des: '',
    imageUrl: fav.imageUrl,
    category: fav.category,
    createdAt: fav.createdAt,
    userId: fav.userId,
    isUserPost: false,
    isBreaking: false,
  ))
      .toList();

  bool isFavorite(String newsId) =>
      favorites.any((item) => item.newsId == newsId);

  FavoritesState copyWith({
    List<FavoriteModel>? favorites,
    bool? loading,
    String? error,
  }) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      loading: loading ?? this.loading,
      error: error,
    );
  }

  factory FavoritesState.initial() => const FavoritesState();
}