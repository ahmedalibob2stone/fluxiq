import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/provider/dependency_provider.dart';
import '../repository/likes_repository.dart';
import '../repository/likes_repository_impl.dart';

final likesRepositoryProvider = Provider<LikesRepository>((ref) {
  final db = ref.read(firebaseFirestoreProvider);
  return LikesRepositoryImpl(db);
});
