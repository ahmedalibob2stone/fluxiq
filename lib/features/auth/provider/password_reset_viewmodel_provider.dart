
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/password_reset_state.dart';
import '../viewmodel/password_reset_view_model.dart';
import 'auth_repository_provider.dart';

final passwordResetViewModelProvider =
StateNotifierProvider.autoDispose<PasswordResetViewModel, PasswordResetState>(
      (ref) => PasswordResetViewModel(ref.read(authRepositoryProvider)),
);