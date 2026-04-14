import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/provider/current_user_id_provider.dart';

import '../../../../core/router/app_route_names.dart.dart';
import '../../../favorites/provider/favorites_viewmodel_provider.dart';
import '../../../favorites/provider/specific_favorite_provider.dart';
import '../../core/widgets/fluxiq_confirmation_dialog.dart';
import '../../core/widgets/safe_cached_image.dart';
import '../../model/news_model.dart';

import '../../provider/vm/publish_news_viewmodel_provider.dart';
class NewsCard extends ConsumerWidget {
  final NewsModel news;
  final bool isMyPost;

  const NewsCard({
    required this.news,
    required this.isMyPost,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,  ref) {
    final currentUser = ref.watch(currentUserIdProvider);
    final isFav = ref.watch(isSpecificFavoriteProvider(news.newsId));

    final screenWidth = MediaQuery.sizeOf(context).width;
    final imageSize = screenWidth * 0.28;

    return RepaintBoundary(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          splashColor: Colors.blue.withOpacity(0.1),
          highlightColor: Colors.transparent,
          onTap: () {
            context.pushNamed(
              AppRouteNames.newsDetails,
              extra: news,
            );
          },
          child: SizedBox(
            height: imageSize,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'news_image_${news.newsId}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SafeCachedImage(
                      imageUrl: news.imageUrl,
                      width: imageSize,
                      height: imageSize,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        news.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2D2D2D),
                          height: 1.3,
                        ),
                      ),
                      Text(
                        news.des,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                SizedBox(
                  height: imageSize,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          isFav ? Icons.bookmark : Icons.bookmark_border,
                          color: isFav ? Colors.amber : Colors.black87,
                        ),
                        onPressed: currentUser == null
                            ? null
                            : () {
                          ref
                              .read(favoritesViewModelProvider(currentUser)
                              .notifier)
                              .toggleFavorite(news);
                        },
                      ),

                      if (isMyPost)
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => FluxIQConfirmationDialog(
                                title: "Delete Post",
                                message:
                                "Are you sure you want to delete this post?",
                                onConfirm: () {
                                  ref
                                      .read(publishingNewsProvider.notifier)
                                      .deleteMyPost(news.newsId);
                                },
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                              size: 22,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}