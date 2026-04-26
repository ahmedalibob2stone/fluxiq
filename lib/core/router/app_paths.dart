class AppPaths {
  AppPaths._();

  //  Auth
  static const String splash         = '/';
  static const String onboarding     = '/onboarding';
  static const String login          = '/login';
  static const String register       = '/register';
  static const String resetPassword  = '/reset-password';
  static const String newPassword    = '/new-password';

  //  News
  static const String home           = '/home';
  static const String newsDetails    = '/home/details';
  static const String createPost     = '/home/create';

  //  User
  static const String liked          = '/liked';
  static const String favorites      = '/favorites';

  //  Notifications
  static const String notifications = '/notifications';
  // في app_paths.dart — أضف فقط هذا السطر
  static const String notificationNewsDetails = '/notification/news/:newsId';
}