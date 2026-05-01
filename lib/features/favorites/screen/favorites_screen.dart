import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxiq/features/favorites/screen/widgets/favorites_content.dart';


import '../../../core/listeners/favorites_state_listener.dart';
import '../../../core/provider/current_user_id_provider.dart';
import '../provider/favorites_viewmodel_provider.dart';
import 'widgets/favorites_app_bar.dart';

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

    final favState = ref.watch(favoritesViewModelProvider(currentUser));
    final favVM = ref.read(favoritesViewModelProvider(currentUser).notifier);

    return FavoritesStateListener(
      userId: currentUser,
      child: Scaffold(
        appBar: const FavoritesAppBar(),
        body: SafeArea(
          child: Builder(
            builder: (context) {
              if (favState.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (favState.convertedNews.isEmpty) {
                return const Center(
                  child: Text(
                    "No favorites yet",
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }

              return FavoritesContent(
                news: favState.convertedNews,
                onRefresh: () => favVM.loadFavorites(),
                isOwnPost: (newsItem) => favVM.isOwnPost(newsItem),
              );
            },
          ),
        ),
      ),
    );
  }
}
