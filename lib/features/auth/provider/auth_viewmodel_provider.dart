import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/auth_state.dart';
import '../viewmodel/auth_viewmodel.dart';
import 'auth_repository_provider.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
      (ref) => AuthViewModel(ref.read(authRepositoryProvider)),
);