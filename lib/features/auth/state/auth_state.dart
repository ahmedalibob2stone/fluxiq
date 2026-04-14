  import '../model/user_model.dart';
  enum AuthStatus { unknown, authenticated, unauthenticated }

  class AuthState {
    final UserModel? user;
    final bool loading;
    final String? error;
    final String? success;
    final bool isGoogleLoading;
    final AuthStatus? status;
    AuthState({
      this.user,
      this.loading = false,
      this.error,
      this.success,
      this.isGoogleLoading = false,
      this.status = AuthStatus.unknown,
    });

    AuthState copyWith({
      UserModel? user,
      bool clearUser = false,
      bool? loading,
      String? error,
      bool clearError = false,
      String? success,
      bool clearSuccess = false,
      bool? isGoogleLoading,
      AuthStatus? status,
    }) {
      return AuthState(
        user: clearUser ? null : (user ?? this.user),
        loading: loading ?? this.loading,
        error: clearError ? null : (error ?? this.error),
        success: clearSuccess ? null : (success ?? this.success),
        isGoogleLoading: isGoogleLoading ?? this.isGoogleLoading,
        status: status ?? this.status,

      );
    }
  }