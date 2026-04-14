import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../repository/new_views_repository.dart';
import '../../repository/new_views_repository_impl.dart';
import '../datasorce/location_remote_datasource_provider.dart';
import '../datasorce/news_views_local_datasource_provider.dart';
import '../datasorce/views_remote_datasorce_provider.dart';

final newsViewsRepositoryProvider = Provider<NewsViewsRepository>((ref) {
  final viewRemote       = ref.read(viewsRemoteDatasourceProvider);
  final location = ref.read(locationRemoteDatasourceProvider);
  final local    = ref.read(viewsLocalDatasourceProvider);
  return NewsViewsRepositoryImpl(viewRemote, location, local);
});
