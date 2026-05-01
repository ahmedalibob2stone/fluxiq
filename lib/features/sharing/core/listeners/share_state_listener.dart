import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/vm/new_sharing_vm_provider.dart';
import '../../state/share_state.dart';

class ShareStateListener extends ConsumerWidget {
  final Widget child;

  const ShareStateListener({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<ShareState>(shareViewModelProvider, (previous, next) {
      if (next.status == ShareStatus.success) {
        Navigator.pop(context);

        if (next.lastPlatform == "CopyLink") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Link copied to clipboard!",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }

        ref.read(shareViewModelProvider.notifier).reset();
      } else if (next.status == ShareStatus.failure &&
          next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            behavior: SnackBarBehavior.floating,
          ),
        );
        ref.read(shareViewModelProvider.notifier).reset();
      }
    });

    return child;
  }
}
