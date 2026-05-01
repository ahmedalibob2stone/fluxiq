import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxiq/features/news/screens/news_datalis/listeners/translation_state_listener.dart';
import 'package:fluxiq/features/sharing/core/listeners/share_state_listener.dart';

import '../../../../../../core/provider/current_user_id_provider.dart';
import '../../../../../../core/listeners/favorites_state_listener.dart';


class NewsDetailsListeners extends ConsumerWidget {
  final String newsId;
  final Widget child;

  const NewsDetailsListeners({
    required this.newsId,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(currentUserIdProvider);

    return TranslationStateListener(
      newsId: newsId,
      child: ShareStateListener(
        child: userId != null
            ? FavoritesStateListener(
          userId: userId,
          child: child,
        )
            : child,
      ),
    );
  }
}
