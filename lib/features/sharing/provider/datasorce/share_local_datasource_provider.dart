import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/provider/shared_preference_provider.dart';
import '../../datasource/local/share_local_datasource.dart';
import '../../datasource/local/share_local_datasource_impl.dart';


final shareLocalDatasourceProvider = Provider<ShareLocalDatasource>((ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  return ShareLocalDatasourceImpl(prefs);
});