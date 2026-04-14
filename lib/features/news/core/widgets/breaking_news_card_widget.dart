import 'package:flutter/material.dart';
import 'package:fluxiq/features/news/core/widgets/safe_cached_image.dart';
import '../../ui/news_details_screen.dart';

class BreakingNewsCard extends StatelessWidget {
  final dynamic news;
  final double width;

  const BreakingNewsCard({
    Key? key,
    required this.news,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => NewsDetailsScreen(news: news),
        ),
      ),
      child: Container(
        width: width,
        margin: const EdgeInsets.only(right: 12),
        child: Stack(
          children: [
            SafeCachedImage(
              imageUrl: news.imageUrl ?? "",
              width: width,
              height: double.infinity,
              borderRadius: BorderRadius.circular(16),
            ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Text(
                news.title ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}