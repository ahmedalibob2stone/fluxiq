// lib/features/notification/presentation/state/notification_state.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import '../model/notification_model.dart';

part 'notification_state.freezed.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState({
    @Default([]) List<NotificationModel> notifications,
    @Default(0) int unreadCount,
    @Default(false) bool isLoading,
    @Default(false) bool isMarkingAllRead,
    String? errorMessage,
  }) = _NotificationState;
}