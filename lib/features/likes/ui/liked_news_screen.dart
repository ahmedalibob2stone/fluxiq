import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../news/ui/widgets/news_card.dart';
import '../provider/user_likes_viewmodel_provider.dart';


class LikedNewsScreen extends ConsumerWidget {
  const LikedNewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(userLikesHistoryProvider.notifier);
    final state = ref.watch(userLikesHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Liked News"),
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
      body: () {
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

        final items = state.likedNewsItems;

        return RefreshIndicator(
          onRefresh: () => viewModel.refreshUserLikesHistory(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWideScreen = constraints.maxWidth > 600;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: isWideScreen
                    ? GridView.builder(
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 3 / 2,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) => NewsCard(
                    news: items[index].news,
                    isMyPost: false,
                  ),
                )
                    : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: items.length,
                  itemBuilder: (context, index) =>

                      Padding(

                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: NewsCard(
                      news: items[index].news,
                      isMyPost: false,
                    ),

                  ),
                ),
              );
            },
          ),
        );
      }(),
    );
  }
}