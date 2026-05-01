import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/fluxiq_snackbar.dart';
import '../../features/favorites/provider/favorites_viewmodel_provider.dart';
import '../../features/favorites/state/favorites_state.dart';

class FavoritesStateListener extends ConsumerWidget {
  final String userId;
  final Widget child;

  const FavoritesStateListener({
    required this.userId,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<FavoritesState>(
      favoritesViewModelProvider(userId),
          (previous, next) {
        if (next.error != null && next.error != previous?.error) {
          FluxIQSnackBar.showError(context, next.error!);
        }
      },
    );

    return child;
  }
}
