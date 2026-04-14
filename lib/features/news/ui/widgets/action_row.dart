import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/provider/current_user_id_provider.dart';
import '../../../favorites/provider/favorites_viewmodel_provider.dart';
import '../../../favorites/provider/specific_favorite_provider.dart';
import '../../../sharing/widgets/share_options_widget.dart';
import '../../model/news_model.dart';

class ActionsRow extends ConsumerWidget {
  final NewsModel news;

  const ActionsRow({required this.news});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(currentUserIdProvider);

    final isFav = ref.watch(isSpecificFavoriteProvider(news.newsId));

    return Row(
      children: [
        IconButton(
          visualDensity: VisualDensity.compact,
          icon: Icon(
            isFav ? Icons.bookmark : Icons.bookmark_border,
            color: isFav ? Colors.amber : Colors.black87,
          ),
          onPressed: userId == null
              ? null
              : () {
            ref
                .read(favoritesViewModelProvider(userId).notifier)
                .toggleFavorite(news);
          },
        ),
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (_) => ShareOptionsWidget(news: news),
            );
          },
        ),
      ],
    );
  }
}