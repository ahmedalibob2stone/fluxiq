import 'package:flutter/cupertino.dart';

import '../entity/onboarding_entity.dart';

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
    title: 'Leave Your Mark',
    subtitle: 'Like what moves you, save what defines you,share what the world needs to hear.',
    isTopText: true,
    textAlign: TextAlign.left,
    crossAlign: CrossAxisAlignment.start,
  ),
  OnboardingEntity(

    textAlign: TextAlign.start,
    crossAlign: CrossAxisAlignment.center,
    imageAsset: 'assets/images/onboarding_4.png',
    title: 'Your world of news in one place',
    subtitle:
    'Start publishing exclusive news, receive notifications as soon as they are published.',
    customTitleSize: 22,
    customSubtitleSize: 14,
  ),
];