
enum PasswordResetStep {
  enterEmail,
  emailSent,
}

class PasswordResetState {
  final PasswordResetStep step;
  final String email;
  final bool loading;
  final String? error;
  final String? success;
  final int resendCooldown;

  const PasswordResetState({
    this.step = PasswordResetStep.enterEmail,
    this.email = '',
    this.loading = false,
    this.error,
    this.success,
    this.resendCooldown = 0,
  });

  PasswordResetState copyWith({
    PasswordResetStep? step,
    String? email,
    bool? loading,
    String? error,
    String? success,
    int? resendCooldown,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return PasswordResetState(
      step: step ?? this.step,
      email: email ?? this.email,
      loading: loading ?? this.loading,
      error: clearError ? null : (error ?? this.error),
      success: clearSuccess ? null : (success ?? this.success),
      resendCooldown: resendCooldown ?? this.resendCooldown,
    );
  }
}