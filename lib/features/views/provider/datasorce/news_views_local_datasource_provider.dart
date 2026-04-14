
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/provider/shared_preference_provider.dart';
import '../../datasource/local/views_local_datasource.dart';
import '../../datasource/local/views_local_datasource_impl.dart';

final viewsLocalDatasourceProvider = Provider<ViewsLocalDatasource>((ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  return ViewsLocalDatasourceImpl(prefs);
});