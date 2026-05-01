import 'package:flutter/material.dart';

class GradientTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final List<Color> gradientColors;

  const GradientTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.fontSize = 16,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    this.gradientColors = const [Color(0xFF1E88E5), Color(0xFF8E24AA)], // ✅ Default يحافظ على السلوك الحالي
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onPressed,
      child: Padding(
        padding: padding,
        child: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(bounds),
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}