import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'current_user_id_provider.dart';

final isAuthenticatedProvider = Provider<bool>((ref) {
  final uid = ref.watch(currentUserIdProvider);
  return uid != null;
});