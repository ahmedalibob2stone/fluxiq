
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxiq/features/news/provider/repository/repository_provider.dart';

import '../../state/news_state.dart';
import '../../viewmodel/breaking_news_viewmodel.dart';

final breakingNewsProvider = StateNotifierProvider.autoDispose<BreakingNewsViewModel, NewsState>((ref) {
  final repo = ref.watch(newsRepositoryProvider);
  return BreakingNewsViewModel(repo);
});
