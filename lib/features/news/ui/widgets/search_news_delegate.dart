import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/widgets/search_empty_widget.dart';
import '../../core/widgets/search_error_widgets.dart';

import '../../provider/vm/search_news_viewmodel_provider.dart';
import '../../state/news_state.dart';
import 'news_card.dart';

class SearchNewsDelegate extends SearchDelegate {
  final WidgetRef ref;


  SearchNewsDelegate(this.ref,);

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        query = '';
        ref.read(searchNewsViewModelProvider.notifier).clearSearch();
      },
    ),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, null),
  );

  @override
  Widget buildResults(BuildContext context) => _buildSearchContent(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildSearchContent(context);

  Widget _buildSearchContent(BuildContext context) {

    Future.microtask(() {
      ref.read(searchNewsViewModelProvider.notifier).onQueryChanged(query);
    });

    return Consumer(
      builder: (context, ref, child) {
        _listenToErrors(context, ref);

        final state = ref.watch(searchNewsViewModelProvider);

        if (state.loading && state.news.isEmpty) {
          return const Center(
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          );
        }

        if (state.error != null && state.news.isEmpty) {
          return SearchErrorWidget(
            error: state.error!,
            onRetry: () => ref.read(searchNewsViewModelProvider.notifier).onQueryChanged(query),
          );
        }

        if (state.news.isEmpty && query.isNotEmpty && !state.loading) {
          return const SearchEmptyWidget();
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          itemCount: state.news.length,
          cacheExtent: 1500,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final newsItem = state.news[index];
            final searchVM = ref.read(searchNewsViewModelProvider.notifier);
            final bool isMyPost = searchVM.canDeletePost(newsItem.userId, newsItem.isUserPost);
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: NewsCard(
                news: newsItem,
           isMyPost: isMyPost,
              ),
            );
          },
        );
      },
    );
  }

  void _listenToErrors(BuildContext context, WidgetRef ref) {
    ref.listen<NewsState>(searchNewsViewModelProvider, (previous, next) {
      if (next.error != null && previous?.error != next.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    });
  }
}



