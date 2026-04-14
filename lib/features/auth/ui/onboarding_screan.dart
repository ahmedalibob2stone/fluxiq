import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_route_names.dart.dart';
import '../core/entity/onboarding_entity.dart';
import '../core/widgets/gradient_button.dart';
import '../core/widgets/page_back_ground.dart';
import '../core/widgets/page_indicaroe.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool get _isLastPage => _currentPage == onboardingPages.length - 1;


  void _nextOrFinish() {
    if (_isLastPage) {
      context.goNamed(AppRouteNames.login);
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = onboardingPages[_currentPage];

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemCount: onboardingPages.length,
            itemBuilder: (_, index) => PageBackground(
              imageAsset: onboardingPages[index].imageAsset,
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            top: page.isTopText
                ? MediaQuery.of(context).padding.top + 40
                : null,
            bottom: page.isTopText ? null : 180,
            left: 24,
            right: 24,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: Column(
                key: ValueKey(_currentPage),
                crossAxisAlignment: page.crossAlign,
                children: [
                  Text(
                    page.title,
                    textAlign: page.textAlign,
                    style: TextStyle(
                      fontSize: page.titleSize,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -0.5,
                      shadows: const [
                        Shadow(
                          color: Colors.black45,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    page.subtitle,
                    textAlign: page.textAlign,
                    style: TextStyle(
                      fontSize: page.subtitleSize,
                      height: 1.4,
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
                      shadows: const [
                        Shadow(color: Colors.black45, blurRadius: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PageIndicator(
                  count: onboardingPages.length,
                  current: _currentPage,
                ),
                const SizedBox(height: 35),
                GradientButton(
                  text: _isLastPage ? 'GET STARTED' : 'NEXT',
                  onPressed: _nextOrFinish,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




