import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/widgets/fluxiq_snackbar.dart';
import '../../../provider/password_reset_viewmodel_provider.dart';


class ResentNewPasswordListeners extends ConsumerWidget {
  final Widget child;

  const ResentNewPasswordListeners({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      passwordResetViewModelProvider.select((s) => s.success),
          (prev, next) {
        if (next != null && next != prev) {
          FluxIQSnackBar.showSuccess(context, next);
        }
      },
    );

    ref.listen(
      passwordResetViewModelProvider.select((s) => s.error),
          (prev, next) {
        if (next != null && next != prev) {
          FluxIQSnackBar.showError(context, next);
        }
      },
    );

    return child;
  }
}
