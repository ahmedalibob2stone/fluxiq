
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxiq/features/likes/core/extensions/number_formatter_likes_extension.dart';

import '../../../core/error/app_exception.dart';
import '../../news/model/news_model.dart';
import '../../notification/repository/notification_repository.dart';
import '../model/like_model.dart';
import '../repository/likes_repository.dart';
import '../state/likes_state.dart';

class LikesViewModel extends StateNotifier<LikesState> {
  final LikesRepository _repository;
  final NotificationRepository _notificationRepository;
  final String newsId;
  final String userId;
  final String name;
  final String email;

  StreamSubscription<int>? _likesCountSub;
  StreamSubscription<bool>? _isLikedSub;
  bool _isProcessing = false;

  LikesViewModel({
    required LikesRepository repository,
    required NotificationRepository notificationRepository,
    required this.newsId,
    required this.userId,
    required this.name,
    required this.email,
  })  : _repository = repository,
        _notificationRepository = notificationRepository,
        super(LikesState.initial()) {
    _initialize();
  }

  String get formattedLikes => state.likesCount.toCompactFormatForLikes();

  void _initialize() {
    _likesCountSub = _repository.likesCount(newsId).listen(
          (count) => state = state.copyWith(likesCount: count),
      onError: (error) {
        if (error is AppException) {
          state = state.copyWith(error: error.message);
        }
      },
    );

    _isLikedSub = _repository
        .isLiked(newsId: newsId, userId: userId)
        .listen(
          (liked) => state = state.copyWith(isLiked: liked),
      onError: (error) {
        if (error is AppException) {
          state = state.copyWith(error: error.message);
        }
      },
    );
  }

  Future<void> toggleLike(NewsModel news) async {
    if (_isProcessing) return;
    _isProcessing = true;

    final previousState = state;

    try {
      final newLikedState = !state.isLiked;
      final newCount = newLikedState
          ? state.likesCount + 1
          : (state.likesCount - 1).clamp(0, double.infinity).toInt();

      // Optimistic Update
      state = state.copyWith(
        isLiked: newLikedState,
        likesCount: newCount,
        error: null,
      );

      final likeModel = LikeModel(
        newsId: newsId,
        newsTitle: news.title,
        newsDescription: news.des,
        newsImageUrl: news.imageUrl,
        newsUserId: news.userId ?? '',
        likedAt: DateTime.now(),
        category: news.category,
        email: email,
        name: name,
      );

      // ── 1. تنفيذ الإعجاب في Firestore ────────────────────────────
      await _repository.toggleLike(
        newsId: newsId,
        userId: userId,
        like: likeModel,
        isCurrentlyLiked: previousState.isLiked,
      );

      // ── 2. إرسال إشعار فقط عند الإعجاب الجديد ────────────────────
      // نفشل بصمت — لا يوقف تدفق الإعجاب أبداً
      if (newLikedState) {
        _notificationRepository
            .sendLikeNotification(
          newsId: newsId,
          newsTitle: news.title,
          newsImageUrl: news.imageUrl,
          authorId: news.userId ?? '',     // صاحب المقال
          senderId: userId,                 // من أعجب
          senderUsername: name,
          currentLikesCount: newCount,
        )
            .catchError((_) {});
      }
    } on AppException catch (e) {
      // Rollback
      state = previousState.copyWith(error: e.message);
    } finally {
      _isProcessing = false;
    }
  }

  @override
  void dispose() {
    _likesCountSub?.cancel();
    _isLikedSub?.cancel();
    super.dispose();
  }
}