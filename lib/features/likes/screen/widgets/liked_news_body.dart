import 'package:flutter/material.dart';

import '../../state/user_likes_history_state.dart';
import '../../viewmodel/user_likes_history_viewmodel.dart';
import 'liked_news_content.dart';

class LikedNewsBody extends StatelessWidget {
  final UserLikesHistoryState state;
  final UserLikesHistoryViewModel viewModel;

  const LikedNewsBody({
    Key? key,
    required this.state,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state.isLoading && !viewModel.hasData) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(state.error!, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => viewModel.refreshUserLikesHistory(),
              child: const Text("Retry"),
            ),
          ],
        ),
      );
    }

    if (!viewModel.hasData) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              "No liked news yet.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return LikedNewsContent(
      items: state.likedNewsItems,
      onRefresh: () => viewModel.refreshUserLikesHistory(),
    );
  }
}