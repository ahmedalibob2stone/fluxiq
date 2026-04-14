

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/password_reset_viewmodel_provider.dart';

class ResendLinkButton extends ConsumerWidget {
  const ResendLinkButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cooldown = ref.watch(
      passwordResetViewModelProvider.select((s) => s.resendCooldown),
    );
    final loading = ref.watch(
      passwordResetViewModelProvider.select((s) => s.loading),
    );

    final isDisabled = cooldown > 0 || loading;

    return TextButton(
      onPressed: isDisabled
          ? null
          : () => ref
          .read(passwordResetViewModelProvider.notifier)
          .resendLink(),
      child: Text(
        cooldown > 0
            ? 'Resend link in ${cooldown}s'
            : "Didn't receive the email? Resend",
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: isDisabled
              ? Colors.blueGrey.shade300
              : const Color(0xFF667EEA),
        ),
      ),
    );
  }
}