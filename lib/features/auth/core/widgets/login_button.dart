
import 'package:flutter/material.dart';

import '../../../../core/widgets/fluxiq_button_widget.dart';

  class LogInButton extends StatelessWidget {
    final bool isLoading;
    final VoidCallback onPressed;

    const LogInButton({
      super.key,
      required this.isLoading,
      required this.onPressed,
    });

  @override
  Widget build(BuildContext context) {
    return FluxIQButton(
      label: 'Log In',
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}