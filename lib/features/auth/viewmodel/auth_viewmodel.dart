import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/app_exception.dart';
import '../repository/auth_repository.dart';
import '../state/auth_state.dart';


class AuthViewModel extends StateNotifier<AuthState> {
  final AuthRepository repository;

  AuthViewModel(this.repository) : super(AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(loading: true, clearError: true);
    try {
      final user = await repository.signInWithEmail(email, password);
      state = state.copyWith(
        user: user,
        loading: false,
        status: AuthStatus.authenticated,
      );
    } on AppException catch (e) {
      state = state.copyWith(error: e.message, loading: false);
    } catch (e) {
      state = state.copyWith(
        error: 'Something went wrong, please try again',
        loading: false,
      );
    }
  }

  Future<void> register(String name, String email, String password) async {
    state = state.copyWith(loading: true, clearError: true);
    try {
      final user = await repository.registerWithEmail(name, email, password);
      state = state.copyWith(
        user: user,
        loading: false,
        status: AuthStatus.authenticated,
      );
    } on AppException catch (e) {
      state = state.copyWith(error: e.message, loading: false);
    } catch (e) {
      state = state.copyWith(
        error: 'Something went wrong, please try again',
        loading: false,
      );
    }
  }

  Future<void> signInWithGoogle() async {
    state = state.copyWith(isGoogleLoading: true, clearError: true);
    try {
      final user = await repository.signInWithGoogle();
      if (user != null) {
        state = state.copyWith(
          user: user,
          isGoogleLoading: false,
          status: AuthStatus.authenticated,
        );
      } else {
        state = state.copyWith(
          error: 'Google sign in cancelled',
          isGoogleLoading: false,
        );
      }
    } on AppException catch (e) {
      state = state.copyWith(error: e.message, isGoogleLoading: false);
    } catch (e) {
      state = state.copyWith(
        error: 'Google sign in failed',
        isGoogleLoading: false,
      );
    }
  }

  Future<void> checkUser() async {
    state = state.copyWith(loading: true, clearError: true);
    try {
      final user = await repository.checkAuthStatus();
      state = state.copyWith(
        user: user,
        loading: false,
        status: user != null
            ? AuthStatus.authenticated
            : AuthStatus.unauthenticated,
      );
    } on AppException catch (e) {
      state = state.copyWith(
        error: e.message,
        loading: false,
        status: AuthStatus.unauthenticated,
      );
    } catch (e) {
      state = state.copyWith(
        loading: false,
        status: AuthStatus.unauthenticated,
      );
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(loading: true, clearError: true);
    try {
      await repository.signOut();
      state = AuthState(status: AuthStatus.unauthenticated);
    } on AppException catch (e) {
      state = state.copyWith(error: e.message, loading: false);
    } catch (e) {
      state = state.copyWith(
        error: 'Sign out failed',
        loading: false,
      );
    }
  }
}
