import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/provider/auth_viewmodel_provider.dart';

final currentUserRoleProvider = Provider<String>((ref) {
    final authState = ref.watch(authViewModelProvider);
  return authState.user?.role ?? 'user';
});