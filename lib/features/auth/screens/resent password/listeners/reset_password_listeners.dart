import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/app_route_names.dart.dart';
import '../../../../../core/widgets/fluxiq_snackbar.dart';
import '../../../provider/password_reset_viewmodel_provider.dart';
import '../../../state/password_reset_state.dart';

class ResetPasswordListeners extends ConsumerWidget {
  final Widget child;

  const ResetPasswordListeners({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<PasswordResetState>(
      passwordResetViewModelProvider,
          (prev, next) {
        if (next.error != null && next.error != prev?.error) {
          FluxIQSnackBar.showError(context, next.error!);
        }

        if (next.step == PasswordResetStep.emailSent &&
            prev?.step == PasswordResetStep.enterEmail) {
          FluxIQSnackBar.showSuccess(context, next.success ?? '');
          context.pushNamed(
            AppRouteNames.newPassword,
            queryParameters: {'email': next.email},
          );
        }
      },
    );

    return child;
  }
}
