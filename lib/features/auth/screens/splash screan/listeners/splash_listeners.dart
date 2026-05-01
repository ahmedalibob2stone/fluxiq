import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/router/app_route_names.dart.dart';
import '../../../provider/auth_viewmodel_provider.dart';
import '../../../state/auth_state.dart';

class SplashListeners extends ConsumerWidget {
  final Widget child;

  const SplashListeners({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(
      authViewModelProvider,
          (prev, next) {
        if (!context.mounted) return;

        if (next.status == AuthStatus.authenticated) {
          context.goNamed(AppRouteNames.home);
        } else if (next.status == AuthStatus.unauthenticated) {
          context.goNamed(AppRouteNames.onboarding);
        }
      },
    );
    return child;
  }
}
