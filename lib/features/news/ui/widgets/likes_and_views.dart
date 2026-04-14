import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxiq/features/views/core/extensions/number_formatter_view_extension.dart';

import '../../../likes/model/like_model.dart';
import '../../../likes/provider/likes_viewmodel_family_provider.dart';
import '../../../views/provider/vm/new_view_viewmodel_provider.dart';
import '../../model/news_model.dart';

class LikesAndViewsRow extends ConsumerWidget {
  final NewsModel news;
  final LikeModel? like;

  const LikesAndViewsRow({
    super.key,
    required this.news,
    required this.like,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final likeState = ref.watch(
      likesViewModelProvider(news.newsId).select(
            (state) => (
        state.isLiked,
        state.likesCount,
        state.isLoading,
        ),
      ),
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {

              ref.read(likesViewModelProvider(news.newsId).notifier).toggleLike(news);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  likeState.$1 ? Icons.favorite : Icons.favorite_border,
                  color: likeState.$1 ? Colors.red : Colors.grey.shade700,
                  size: 22,
                ),
                const SizedBox(width: 5),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                      ref.watch(likesViewModelProvider(news.newsId).notifier).formattedLikes,
                    key: ValueKey(likeState.$2),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          Row(
            children: [
              Icon(
                Icons.remove_red_eye_outlined,
                color: Colors.grey.shade700,
                size: 22,
              ),
              const SizedBox(width: 5),

              Text(
                ref.watch(newsViewsProvider(news.newsId)).countView
                    .toCompactFormatForViews(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}