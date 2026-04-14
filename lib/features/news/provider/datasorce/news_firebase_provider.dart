

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/provider/dependency_provider.dart';
import '../../datasorce/firestore/news_firebase_datasource.dart';
import '../../datasorce/firestore/news_firebase_datasource_impl.dart';

final newsFirebaseDatasourceProvider = Provider<NewsFirebaseDatasource>((ref) {
  final db = ref.read(firebaseFirestoreProvider);
  return NewsFirebaseDatasourceImpl(db: db);
});