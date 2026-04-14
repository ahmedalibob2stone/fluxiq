
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/provider/dependency_provider.dart';
import '../../datasource/remote/views_remote_datasource.dart';
import '../../datasource/remote/views_remote_datasource_impl.dart';


final viewsRemoteDatasourceProvider = Provider<ViewsRemoteDatasource>((ref) {
  final db= ref.read(firebaseFirestoreProvider);

  return ViewsRemoteDatasourceImpl(db);
});