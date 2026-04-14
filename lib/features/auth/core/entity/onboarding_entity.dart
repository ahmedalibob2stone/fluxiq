
import 'package:flutter/material.dart';

class OnboardingEntity {
  final String imageAsset;
  final String title;
  final String subtitle;
  final bool isTopText;
  final TextAlign textAlign;
  final CrossAxisAlignment crossAlign;

  const OnboardingEntity({
    required this.imageAsset,
    required this.title,
    required this.subtitle,
    this.isTopText = false,
    this.textAlign = TextAlign.center,
    this.crossAlign = CrossAxisAlignment.center,
  });

  double get titleSize => isTopText ? 28 : 34;
  double get subtitleSize => isTopText ? 15 : 17;
}


const List<OnboardingEntity> onboardingPages = [
  OnboardingEntity(
    imageAsset: 'assets/images/onboarding_1.png',
    title: 'Read Latest News',
    subtitle: 'Stay up to date with industry and world events in real-time.',
  ),
  OnboardingEntity(
    imageAsset: 'assets/images/onboarding_2.png',
    title: 'Deep Discovery',
    subtitle: 'Search across thousands of global sources to find the News.',
    isTopText: true,
  ),
  OnboardingEntity(
    imageAsset: 'assets/images/onboarding_3.png',
    title: 'Save Your Favorites',
    subtitle: 'Bookmark, Likes, share articles with zero friction.',
    isTopText: true,
    textAlign: TextAlign.left,
    crossAlign: CrossAxisAlignment.start,
  ),
  OnboardingEntity(
    imageAsset: 'assets/images/onboarding_4.png',
    title: 'Smart Publishing',
    subtitle: 'Become a creator on FluxIQ. Publish News, share unique perspectives.',
  ),
];