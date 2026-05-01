import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../router/app_paths.dart';
import '../widgets/fluxiq_snackbar.dart';
import '../../features/news/provider/vm/publish_news_viewmodel_provider.dart';
import '../../features/news/state/publish_state.dart';

class PublishStateListener extends ConsumerWidget {
  final Widget child;

  const PublishStateListener({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<PublishNewsState>(publishingNewsProvider, (prev, next) {
      if (next.status == PublishNewsStatus.success) {
        FluxIQSnackBar.showSuccess(context, next.successMessage!);
        ref.read(publishingNewsProvider.notifier).reset();

        Future.delayed(const Duration(milliseconds: 300), () {
          if (context.mounted) {
            // ✅ بدل Navigator.of(context).pop()
            if (context.canPop()) {
              context.pop(); // GoRouter pop
            } else {
              context.go(AppPaths.home); // fallback لو Stack فاضي
            }
          }
        });

      } else if (next.status == PublishNewsStatus.failure) {
        FluxIQSnackBar.showError(context, next.errorMessage!);
      }
    });

    return child;
  }
}