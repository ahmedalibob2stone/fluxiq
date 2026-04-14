import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/provider/current_user_id_provider.dart';
import '../../../core/widgets/fluxiq_snackbar.dart';
import '../../news/ui/widgets/news_card.dart';
import '../provider/favorites_viewmodel_provider.dart';
import '../state/favorites_state.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserIdProvider);

    if (currentUser == null) {
      return const Center(
        child: Text("Please login to see favorites"),
      );
    }
    ref.listen<FavoritesState>(
      favoritesViewModelProvider(currentUser),
          (previous, next) {
        if (next.error != null && next.error != previous?.error) {
          FluxIQSnackBar.showError(context, next.error!);
        }
      },
    );

    final favState = ref.watch(favoritesViewModelProvider(currentUser));
    final favVM = ref.read(
      favoritesViewModelProvider(currentUser).notifier,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Favorites"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1E88E5), Color(0xFF8E24AA)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
      body: favState.loading
          ? const Center(child: CircularProgressIndicator())
          : favState.convertedNews.isEmpty
          ? const Center(
        child: Text(
          "No favorites yet",
          style: TextStyle(fontSize: 16),
        ),
      )
          : RefreshIndicator(
        onRefresh: () => favVM.loadFavorites(),
        child: ListView.builder(
          itemCount: favState.convertedNews.length,
          itemBuilder: (_, index) {
            final newsItem = favState.convertedNews[index];
            return NewsCard(
              news: newsItem,
              isMyPost: favVM.isOwnPost(newsItem),
            );
          },
        ),
      ),
    );
  }
}
