
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';


import '../../features/auth/ui/login_screan.dart';
import '../../features/auth/ui/new_password_screen.dart';
import '../../features/auth/ui/onboarding_screan.dart';
import '../../features/auth/ui/register_screan.dart';
import '../../features/auth/ui/reset_password_screan.dart';
import '../../features/auth/ui/splash_screan.dart';
import '../../features/favorites/ui/favorites_screen.dart';
import '../../features/likes/ui/liked_news_screen.dart';
import '../../features/news/model/news_model.dart';


import '../../features/news/ui/home_screen.dart';
import '../../features/news/ui/news_details_screen.dart';
import '../../features/news/ui/create_post_screan.dart';
import '../../features/news/ui/notification_news_screan .dart';
import '../../features/notification/screens/notifications_screen.dart';
import 'app_paths.dart';
import 'app_route_names.dart.dart';

  List<RouteBase> appRoutes() => [

    //  Splash
    GoRoute(
      path: AppPaths.splash,
      name: AppRouteNames.splash,
      builder: (context, state) => const FluxIQSplashScreen(),
    ),

    //  Onboarding
    GoRoute(
      path: AppPaths.onboarding,
      name: AppRouteNames.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),

    //  Login
    GoRoute(
      path: AppPaths.login,
      name: AppRouteNames.login,
      builder: (context, state) => const LoginScreen(),
    ),

    // Register
    GoRoute(
      path: AppPaths.register,
      name: AppRouteNames.register,
      builder: (context, state) => const RegisterScreen(),
    ),

    //  Reset Password
    GoRoute(
      path: AppPaths.resetPassword,
      name: AppRouteNames.resetPassword,
      builder: (context, state) => const ResetPasswordScreen(),
    ),

    //  New Password
    GoRoute(
      path: AppPaths.newPassword,
      name: AppRouteNames.newPassword,
      builder: (context, state) {
        final email = state.uri.queryParameters['email'] ?? '';
        return NewPasswordScreen(email: email);
      },
    ),

    //  News Home
    GoRoute(
      path: AppPaths.home,
      name: AppRouteNames.home,
      builder: (context, state) => const NewsHomeScreen(),
    ),

    //News Details
// في app_routes.dart — أضف هذا الـ Route مع باقي الـ Routes

// ✅ الـ Route الموجود — لا تغيير عليه أبداً
    GoRoute(
      path: AppPaths.newsDetails,
      name: AppRouteNames.newsDetails,
      pageBuilder: (context, state) {
        final news = state.extra as NewsModel;
        return CustomTransitionPage(
          key: state.pageKey,
          child: NewsDetailsScreen(news: news),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    ),

    GoRoute(
      path: AppPaths.notificationNewsDetails,
      name: AppRouteNames.notificationNewsDetails,
      pageBuilder: (context, state) {
        final newsId = state.pathParameters['newsId'] ?? '';
        return CustomTransitionPage(
          key: state.pageKey,
          child: NotificationNewsScreen(newsId: newsId),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    ),
    //  Create Post
    GoRoute(
      path: AppPaths.createPost,
      name: AppRouteNames.createPost,
      builder: (context, state) => const CreatePostScreen(),
    ),

    //  Liked News
    GoRoute(
      path: AppPaths.liked,
      name: AppRouteNames.liked,
      builder: (context, state) => const LikedNewsScreen(),
    ),

    //  Favorites
    GoRoute(
      path: AppPaths.favorites,
      name: AppRouteNames.favorites,
      builder: (context, state) => const FavoritesScreen(),
    ),
    GoRoute(
      path: AppPaths.notifications,
      name: AppRouteNames.notifications,
      builder: (context, state) => const NotificationsScreen(),
    ),
  ];