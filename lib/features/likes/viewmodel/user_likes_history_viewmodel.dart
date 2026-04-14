import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/app_exception.dart';
import '../../news/model/news_model.dart';
import '../model/like_model.dart';
import '../repository/likes_repository.dart';
import '../state/user_likes_history_state.dart';

class UserLikesHistoryViewModel extends StateNotifier<UserLikesHistoryState> {
  final LikesRepository _repository;
  final String? currentUserId;

  UserLikesHistoryViewModel({
    required LikesRepository repository,
    required this.currentUserId,
  })  : _repository = repository,
        super(UserLikesHistoryState.initial()) {
    fetchUserLikesHistory();
  }

  StreamSubscription<List<LikeModel>>? _userLikesHistorySub;

  List<LikedNewsItem> get likedNewsItems => state.likedNewsItems;
  bool get isLoading => state.isLoading;
  bool get hasData => state.userLikesHistory != null;
  bool get isEmpty => state.userLikesHistory?.isEmpty ?? true;
  String? get errorMessage => state.error;

  void fetchUserLikesHistory() {
    _userLikesHistorySub?.cancel();

    state = state.copyWith(isLoading: true, error: null);

    _userLikesHistorySub = _repository.getUserLikedNews(currentUserId!).listen(
          (likes) {
        final likedNewsItems = _convertToLikedNewsItems(likes);
        state = state.copyWith(
          userLikesHistory: likes,
          likedNewsItems: likedNewsItems,
          isLoading: false,
        );
      },
      onError: (error) {
        if (error is AppException) {
          state = state.copyWith(
            error: error.message,
            isLoading: false,
          );
        } else {
          state = state.copyWith(
            error: 'Something went wrong',
            isLoading: false,
          );
        }
      },
    );
  }

  Future<void> refreshUserLikesHistory() async {
    fetchUserLikesHistory();
  }

  List<LikedNewsItem> _convertToLikedNewsItems(List<LikeModel> likes) {
    return likes.map((like) {
      final news = _convertLikeToNews(like);
      final canDelete = _isCurrentUserTheAuthor(like.newsUserId);

      return LikedNewsItem(
        news: news,
        canDelete: canDelete,
      );
    }).toList();
  }

  NewsModel _convertLikeToNews(LikeModel like) {
    return NewsModel(
      newsId: like.newsId,
      title: like.newsTitle,
      des: like.newsDescription,
      imageUrl: like.newsImageUrl,
      userId: like.newsUserId,
      isUserPost: _isCurrentUserTheAuthor(like.newsUserId),
      category: like.category,
      createdAt: like.likedAt,
      isBreaking: false,
    );
  }

  bool _isCurrentUserTheAuthor(String? newsAuthorId) {
    if (currentUserId == null || currentUserId!.isEmpty) return false;
    if (newsAuthorId == null || newsAuthorId.isEmpty) return false;
    return newsAuthorId == currentUserId;
  }

  @override
  void dispose() {
    _userLikesHistorySub?.cancel();
    super.dispose();
  }
}