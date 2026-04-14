import 'package:flutter/material.dart';

class FluxIQTitle extends StatelessWidget {
  final double fontSize;

  const FluxIQTitle({
    super.key,
    this.fontSize = 32,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: const [
            Color(0xFF1E88E5),
            Color(0xFF8E24AA),
          ],
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: Text(
        'FluxIQ',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
          fontFamily: 'MyCustomFont',
          color: Colors.white,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
