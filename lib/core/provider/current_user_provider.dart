import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/model/user_model.dart';
import '../../features/auth/provider/auth_viewmodel_provider.dart';

final currentUserProvider = Provider<UserModel?>((ref) {
  final authState = ref.watch(authViewModelProvider);
  return authState.user;
});