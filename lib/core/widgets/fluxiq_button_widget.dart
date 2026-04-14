import 'package:flutter/material.dart';

class FluxIQButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final BorderSide? side;

  const FluxIQButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.side,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null && !isLoading;

    final bool useGradient = backgroundColor == null;

    return Container(

      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        color: !useGradient ? (isEnabled ? backgroundColor : Colors.grey.shade200) : null,
        gradient: useGradient
            ? (isEnabled
            ? const LinearGradient(
          colors: [Color(0xFF1E88E5), Color(0xFF8E24AA)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        )
            : LinearGradient(colors: [Colors.grey.shade400, Colors.grey.shade400]))
            : null,
        borderRadius: BorderRadius.circular(12),
        border: side != null ? Border.fromBorderSide(side!) : null,
        boxShadow: [
          if (isEnabled && useGradient)
            BoxShadow(
              color: const Color(0xFF1E88E5).withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: isLoading
                ? SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                color: useGradient ? Colors.white : const Color(0xFF1E88E5),
                strokeWidth: 2.5,
              ),
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  icon!,
                  const SizedBox(width: 12),
                ],
                Text(
                  label,
                  style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}