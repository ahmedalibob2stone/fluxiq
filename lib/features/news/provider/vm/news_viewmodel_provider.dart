import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxiq/features/news/provider/repository/repository_provider.dart';

import '../../../../core/provider/current_user_id_provider.dart';
import '../../../../core/provider/current_user_role_provider.dart';

import '../../state/news_state.dart';
import '../../viewmodel/news_viewmodel.dart';

      final newsViewModelProvider =
      StateNotifierProvider.autoDispose<NewsViewModel, NewsState>((ref) {
      final userId = ref.watch(currentUserIdProvider);
            final userRole = ref.watch(currentUserRoleProvider);
           return NewsViewModel(
                  repository: ref.read(newsRepositoryProvider),
                  currentUserId: userId ?? '',
                  currentUserRole: userRole,);});