import 'package:flutter/material.dart';
import '../../../core/widgets/safe_cached_image.dart';

class NewsHeaderImage extends StatelessWidget {
  final String newsId;
  final String imageUrl;
  final double height;

  const NewsHeaderImage({
    required this.newsId,
    required this.imageUrl,
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: newsId,
      child: SafeCachedImage(
        imageUrl: imageUrl,
        width: double.infinity,
        height: height,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}