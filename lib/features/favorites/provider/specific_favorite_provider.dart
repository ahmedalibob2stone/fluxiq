import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/provider/current_user_id_provider.dart';
import 'favorites_viewmodel_provider.dart';

final isSpecificFavoriteProvider =
Provider.autoDispose.family<bool, String>((ref, newsId) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return false;

  final favorites = ref.watch(
    favoritesViewModelProvider(userId)
        .select((state) => state.favorites),
  );

  return favorites.any((item) => item.newsId == newsId);
});