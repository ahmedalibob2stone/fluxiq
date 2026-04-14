import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxiq/features/news/provider/repository/repository_provider.dart';
import '../../../../core/provider/current_user_id_provider.dart';
import '../../../../core/provider/connectivity_datasorce_provider.dart';
import '../../state/publish_state.dart';
import '../../viewmodel/publishing_news_viewmodel.dart';

final publishingNewsProvider =
StateNotifierProvider.autoDispose <PublishingNewsViewModel, PublishNewsState>((ref) {
  final repository = ref.read(newsRepositoryProvider);

  final userId = ref.watch(currentUserIdProvider);

  final connectivity = ref.read(connectivityDatasourceProvider);
  return PublishingNewsViewModel(
    repository: repository,
    userId: userId,
    connectivityDatasource: connectivity,
  );
});
