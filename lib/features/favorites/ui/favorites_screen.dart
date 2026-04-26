import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
      return const Scaffold(
        body: Center(
          child: Text("Please login to see favorites"),
        ),
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
    final favVM = ref.read(favoritesViewModelProvider(currentUser).notifier);

    final screenWidth = MediaQuery.sizeOf(context).width;
    final horizontalPadding = screenWidth > 600 ? screenWidth * 0.08 : 0.0;

    return Scaffold(
      appBar: AppBar(
        leading: context.canPop()
            ? IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => context.pop(),
        )
            : null,
        title: const Text(
          'My Favorites',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
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
      body: SafeArea(
        child: favState.loading
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
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
            ),
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
      ),
    );
  }
}