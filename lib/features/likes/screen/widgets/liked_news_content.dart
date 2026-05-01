import 'package:flutter/material.dart';

import '../../../news/screens/home/widgets/news_card.dart';


class LikedNewsContent extends StatelessWidget {
  final List<dynamic> items;
  final Future<void> Function() onRefresh;

  const LikedNewsContent({
    Key? key,
    required this.items,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWideScreen = constraints.maxWidth > 600;

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isWideScreen ? constraints.maxWidth * 0.04 : 8.0,
              vertical: 8.0,
            ),
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
              itemBuilder: (context, index) => Padding(
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
  }
}
