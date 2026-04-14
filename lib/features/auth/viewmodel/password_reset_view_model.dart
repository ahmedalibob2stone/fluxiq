
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/app_exception.dart';
import '../repository/auth_repository.dart';
import '../state/password_reset_state.dart';


class PasswordResetViewModel extends StateNotifier<PasswordResetState> {
  final AuthRepository _repository;
  Timer? _resendTimer;

  static const int _cooldownSeconds = 300;

  PasswordResetViewModel(this._repository)
      : super(const PasswordResetState());

  Future<void> sendResetLink(String email) async {
    state = state.copyWith(
      loading: true,
      clearError: true,
      clearSuccess: true,
    );

    try {
      await _repository.resetPassword(email);

      state = state.copyWith(
        email: email,
        step: PasswordResetStep.emailSent,
        loading: false,
        success: 'Reset link has been sent to $email',
      );

      _startResendCooldown();
    } on AppException catch (e) {
      state = state.copyWith(error: e.message, loading: false);
    }
  }

  Future<void> resendLink() async {
    if (state.resendCooldown > 0 || state.email.isEmpty) return;

    state = state.copyWith(
      loading: true,
      clearError: true,
      clearSuccess: true,
    );

    try {
      await _repository.resetPassword(state.email);

      state = state.copyWith(
        loading: false,
        success: 'A new reset link has been sent to ${state.email}',
      );

      _startResendCooldown();
    } on AppException catch (e) {
      state = state.copyWith(error: e.message, loading: false);
    }
  }

  void _startResendCooldown() {
    _resendTimer?.cancel();
    state = state.copyWith(resendCooldown: _cooldownSeconds);

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.resendCooldown <= 1) {
        timer.cancel();
        state = state.copyWith(resendCooldown: 0);
      } else {
        state = state.copyWith(resendCooldown: state.resendCooldown - 1);
      }
    });
  }

  void reset() {
    _resendTimer?.cancel();
    state = const PasswordResetState();
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    super.dispose();
  }
}