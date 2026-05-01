import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/vm/news_viewmodel_provider.dart';
import '../../../state/news_state.dart';

class NewsStateListener extends ConsumerWidget {
  final String? selectedCategory;
  final Widget child;

  const NewsStateListener({
    super.key,
    required this.child,
    this.selectedCategory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<NewsState>(newsViewModelProvider, (previous, next) {
      if (next.error != null && next.error!.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: "Retry",
              textColor: Colors.white,
              onPressed: () {
                ref
                    .read(newsViewModelProvider.notifier)
                    .fetchNews(category: selectedCategory);
              },
            ),
          ),
        );
      }
    });

    return child;
  }
}
