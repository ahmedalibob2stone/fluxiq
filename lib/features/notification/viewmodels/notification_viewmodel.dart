// lib/features/notification/presentation/vm/notification_vm.dart

import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/notification_model.dart';
import '../repository/notification_repository.dart';
import '../state/notification_state.dart';

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

  // ── Private ────────────────────────────────────────────────────────────────

  void _startListening() {
    // مجرى الإشعارات
    _notificationsSub = _repository
        .watchNotifications(_userId)
        .listen(
          (notifications) => state = state.copyWith(
        notifications: notifications,
        errorMessage: null,
      ),
      onError: (e) => state = state.copyWith(
        errorMessage: 'فشل تحميل الإشعارات',
      ),
    );

    // مجرى عدد الإشعارات غير المقروءة
    _unreadCountSub = _repository
        .watchUnreadCount(_userId)
        .listen(
          (count) => state = state.copyWith(unreadCount: count),
      onError: (_) {},
    );
  }

  // ── Public ─────────────────────────────────────────────────────────────────

  /// تحديد إشعار واحد كمقروء
  Future<void> markAsRead(String notificationId) async {
    try {
      await _repository.markAsRead(notificationId);
    } catch (_) {
      // نفشل بصمت — الـ UI لن يتأثر
    }
  }

  /// تحديد جميع الإشعارات كمقروءة
  Future<void> markAllAsRead() async {
    if (state.isMarkingAllRead) return;
    state = state.copyWith(isMarkingAllRead: true);
    try {
      await _repository.markAllAsRead(_userId);
    } catch (e) {
      state = state.copyWith(errorMessage: 'فشل تحديد الكل كمقروء');
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