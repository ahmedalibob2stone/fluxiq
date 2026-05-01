import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxiq/features/likes/screen/widgets/liked_news_content.dart';

import '../provider/user_likes_viewmodel_provider.dart';
import 'widgets/liked_news_app_bar.dart';

class LikedNewsScreen extends ConsumerWidget {
  const LikedNewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(userLikesHistoryProvider.notifier);
    final state = ref.watch(userLikesHistoryProvider);

    return Scaffold(
      appBar: const LikedNewsAppBar(),
      body: SafeArea(
        child: Builder(
          builder: (context) {
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
          },
        ),
      ),
    );
  }
}
