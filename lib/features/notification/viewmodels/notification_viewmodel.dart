
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/notification_model.dart';
import '../repository/notification_repository.dart';
import '../state/notification_state.dart';

import '../../../../core/error/app_exception.dart';

class NotificationViewModel extends StateNotifier<NotificationState> {
  final NotificationRepository _repository;
  final String _userId;

  StreamSubscription<List<NotificationModel>>? _notificationsSub;
  StreamSubscription<int>? _unreadCountSub;

  NotificationViewModel({
    required NotificationRepository repository,
    required String userId,
  })  : _repository = repository,
        _userId = userId,
        super(const NotificationState()) {
    _startListening();
  }

  void _startListening() {
    _notificationsSub = _repository
        .watchNotifications(_userId)
        .listen(
          (notifications) => state = state.copyWith(
        notifications: notifications,
        errorMessage:  null,
      ),
      onError: (Object e) {
        final message = e is AppException
            ? e.message
            : 'Unable to load notifications. Please try again.';

        state = state.copyWith(errorMessage: message);
      },
    );

    _unreadCountSub = _repository
        .watchUnreadCount(_userId)
        .listen(
          (count) => state = state.copyWith(unreadCount: count),
      onError: (_) {
      },
    );
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      await _repository.markAsRead(notificationId);
    } catch (_) {
    }
  }

  Future<void> markAllAsRead() async {
    if (state.isMarkingAllRead) return;

    state = state.copyWith(isMarkingAllRead: true, errorMessage: null);

    try {
      await _repository.markAllAsRead(_userId);
    } catch (e) {
      final message = e is AppException
          ? e.message
          : 'Unable to mark all as read. Please try again.';

      state = state.copyWith(errorMessage: message);
    } finally {
      state = state.copyWith(isMarkingAllRead: false);
    }
  }

  @override
  void dispose() {
    _notificationsSub?.cancel();
    _unreadCountSub?.cancel();
    super.dispose();
  }
}