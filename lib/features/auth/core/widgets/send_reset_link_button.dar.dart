import 'package:flutter/material.dart';
import '../../../../core/widgets/fluxiq_button_widget.dart';

class SendResetLinkButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const SendResetLinkButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FluxIQButton(
      label: 'Send Reset Link',
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}