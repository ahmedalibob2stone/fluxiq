import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxiq/features/news/provider/repository/repository_provider.dart';

import '../../../../core/provider/current_user_id_provider.dart';
import '../../state/news_state.dart';
import '../../viewmodel/search_news_viewmodel.dart';

final searchNewsViewModelProvider =
StateNotifierProvider.autoDispose<SearchNewsViewModel, NewsState>((ref) {
  final repository = ref.watch(newsRepositoryProvider);
  final currentUserId = ref.watch(currentUserIdProvider);
  return SearchNewsViewModel(
    repository: repository,  currentUserId: currentUserId ??'',

  );
});

