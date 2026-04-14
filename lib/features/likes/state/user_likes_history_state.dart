import '../../news/model/news_model.dart';
import '../model/like_model.dart';


class UserLikesHistoryState {
  final List<LikeModel>? userLikesHistory;
  final List<LikedNewsItem> likedNewsItems;
  final bool isLoading;
  final String? error;

  const UserLikesHistoryState({
    this.userLikesHistory,
    this.likedNewsItems = const [],
    required this.isLoading,
    this.error,
  });

  UserLikesHistoryState copyWith({
    List<LikeModel>? userLikesHistory,
    List<LikedNewsItem>? likedNewsItems,
    bool? isLoading,
    String? error,
  }) {
    return UserLikesHistoryState(
      userLikesHistory: userLikesHistory ?? this.userLikesHistory,
      likedNewsItems: likedNewsItems ?? this.likedNewsItems,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  factory UserLikesHistoryState.initial() {
    return const UserLikesHistoryState(
      userLikesHistory: null,
      likedNewsItems: [],
      isLoading: false,
    );
  }
}

class LikedNewsItem {
  final NewsModel news;
  final bool canDelete;

  const LikedNewsItem({
    required this.news,
    required this.canDelete,
  });
}