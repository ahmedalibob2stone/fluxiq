import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/vm/translation_viewmodel_provider.dart';
import '../../../state/translation_state.dart';




class TranslationStateListener extends ConsumerWidget {
  final String newsId;
  final Widget child;

  const TranslationStateListener({
    required this.newsId,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<TranslationState>(
      translationViewModelProvider(newsId),
          (previous, next) {
        if (next.error != null && next.error != previous?.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.error!),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
    );

    return child;
  }
}
