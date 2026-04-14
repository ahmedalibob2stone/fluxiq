
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/app_exception.dart';
import '../repository/new_sharing_repository.dart';
import '../state/share_state.dart';

import '../../news/model/news_model.dart';



class ShareViewModel extends StateNotifier<ShareState> {
  final ShareRepository _repository;
  final String userId;

  static const int _maxShares = 50;

  ShareViewModel(this._repository, this.userId) : super(const ShareState());

  Future<void> share({
    required NewsModel news,
    required String platform,
  }) async {
    try {
      final localCount = _repository.getLocalShareCount(
        newsId: news.newsId,
        userId: userId,
      );

      if (localCount >= _maxShares) {
        state = state.copyWith(
          status: ShareStatus.failure,
          errorMessage: 'You have reached the maximum share limit',
        );
        return;
      }

      await _repository.shareExternally(news: news, platform: platform);

      await _repository.cacheShareEvent(
        newsId: news.newsId,
        userId: userId,
        platform: platform,
      );

      state = state.copyWith(
        status: ShareStatus.success,
        lastPlatform: platform,
        errorMessage: null,
      );

      _repository.syncPendingShares().catchError((_) {});
    } on AppException catch (e) {
      state = state.copyWith(
        status: ShareStatus.failure,
        errorMessage: e.message,
      );
    } catch (_) {
      state = state.copyWith(
        status: ShareStatus.failure,
        errorMessage: 'An error occurred. Try again',
      );
    }
  }

  void reset() {
    state = const ShareState();
  }
}