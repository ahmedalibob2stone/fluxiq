import 'package:flutter/material.dart';

import '../../../news/screens/home/widgets/news_card.dart';


class FavoritesContent extends StatelessWidget {
  final List<dynamic> news;
  final Future<void> Function() onRefresh;
  final bool Function(dynamic newsItem) isOwnPost;

  const FavoritesContent({
    Key? key,
    required this.news,
    required this.onRefresh,
    required this.isOwnPost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final horizontalPadding = screenWidth > 600 ? screenWidth * 0.08 : 0.0;

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        itemCount: news.length,
        itemBuilder: (_, index) {
          final newsItem = news[index];
          return NewsCard(
            news: newsItem,
            isMyPost: isOwnPost(newsItem),
          );
        },
      ),
    );
  }
}
