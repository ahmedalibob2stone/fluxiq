import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_route_names.dart.dart';
import '../../../core/widgets/fluxiq_snackbar.dart';
import '../../features/auth/provider/auth_viewmodel_provider.dart';
import '../../features/auth/state/auth_state.dart';
class AuthListeners extends ConsumerWidget {
  final Widget child;

  const AuthListeners({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(
      authViewModelProvider,
          (previous, next) {
        if (next.error != null && next.error != previous?.error) {
          FluxIQSnackBar.showError(context, next.error!);
        }

        if (next.status == AuthStatus.authenticated &&
            previous?.status != AuthStatus.authenticated) {
          context.goNamed(AppRouteNames.home);
        }
        if (next.status == AuthStatus.unauthenticated &&
            previous?.status != AuthStatus.unauthenticated) {
          context.goNamed(AppRouteNames.login);
        }
          },

    );

    return child;
  }
}

