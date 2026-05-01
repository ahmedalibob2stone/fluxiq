import 'package:flutter/material.dart';

import '../../state/favorites_state.dart';
import '../../viewmodel/favorites_view_model.dart';
import 'favorites_content.dart';

class FavoritesBody extends StatelessWidget {
  final FavoritesState favState;
  final FavoritesViewModel favVM;

  const FavoritesBody({
    Key? key,
    required this.favState,
    required this.favVM,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }
}