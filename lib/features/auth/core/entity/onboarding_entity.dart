
import 'package:flutter/material.dart';

class OnboardingEntity {
  final String imageAsset;
  final String title;
  final String subtitle;
  final bool isTopText;
  final TextAlign textAlign;
  final CrossAxisAlignment crossAlign;
  final double? customTitleSize;
  final double? customSubtitleSize;

  const OnboardingEntity({
    required this.imageAsset,
    required this.title,
    required this.subtitle,
    this.isTopText = false,
    this.textAlign = TextAlign.center,
    this.crossAlign = CrossAxisAlignment.center,
    this.customTitleSize,
    this.customSubtitleSize,
  });

  double get titleSize => customTitleSize ?? (isTopText ? 28 : 34);
  double get subtitleSize => customSubtitleSize ?? (isTopText ? 15 : 17);
}