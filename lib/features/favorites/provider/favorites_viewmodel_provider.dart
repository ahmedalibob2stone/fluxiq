import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/provider/current_user_provider.dart';
import '../state/favorites_state.dart';
import '../viewmodel/favorites_view_model.dart';
import 'favorites_repository_provider.dart';
final favoritesViewModelProvider = StateNotifierProvider
    .family<FavoritesViewModel, FavoritesState, String>((ref, userId) {

  final repository = ref.watch(favoritesRepositoryProvider);
  final vm = FavoritesViewModel(repository, userId);
  Future.microtask(() => vm.loadFavorites());
  return vm;
});