import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/provider/dependency_provider.dart';
import '../repository/favorites_repository.dart';
import '../repository/favorites_repository_impl.dart';

final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  final db = ref.read(firebaseFirestoreProvider);

  return FavoritesRepositoryImpl(db);
});
