import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/provider/current_user_id_provider.dart';
import '../../state/share_state.dart';
import '../../viewmodel/sharing_viewmodel.dart';
import '../repository/new_shared_repository_provider.dart';



final shareViewModelProvider =
StateNotifierProvider.autoDispose<ShareViewModel, ShareState>((ref) {
  final repository = ref.watch(shareRepositoryProvider);
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) throw Exception("User not logged in");
  return ShareViewModel(repository,userId);
});
