import 'package:flutter/material.dart';

class NotificationTypeConfig {
  final String emoji;
  final Color badgeColor;
  final Color avatarColor;
  final Widget Function(
      String newsTitle,
      TextStyle boldStyle,
      TextStyle normalStyle,
      ) buildTitle;

  NotificationTypeConfig({
    required this.emoji,
    required this.badgeColor,
    required this.avatarColor,
    required this.buildTitle,
  });

  static final Map<String, NotificationTypeConfig> _configs = {
    'like': NotificationTypeConfig(
      emoji: '❤️',
      badgeColor: Colors.pink.shade400,
      avatarColor: Colors.pink.shade100,
      buildTitle: (newsTitle, boldStyle, normalStyle) => Text.rich(
        TextSpan(
          children: [
            TextSpan(text: 'Someone liked your news: ', style: boldStyle),
            TextSpan(text: newsTitle, style: normalStyle),
          ],
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ),

    'milestone': NotificationTypeConfig(
      emoji: '🎉',
      badgeColor: Colors.amber.shade400,
      avatarColor: Colors.amber.shade100,
      buildTitle: (newsTitle, boldStyle, normalStyle) => Text.rich(
        TextSpan(
          children: [
            TextSpan(text: '🎉 Your news "', style: boldStyle),
            TextSpan(text: newsTitle, style: normalStyle),
            TextSpan(text: '" reached a milestone!', style: boldStyle),
          ],
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ),

    'breaking_news': NotificationTypeConfig(
      emoji: '📰',
      badgeColor: Colors.red.shade400,
      avatarColor: Colors.red.shade100,
      buildTitle: (newsTitle, boldStyle, normalStyle) => Text.rich(
        TextSpan(
          children: [
            TextSpan(text: '🔴 Breaking: ', style: boldStyle),
            TextSpan(text: newsTitle, style: normalStyle),
          ],
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ),

    'default': NotificationTypeConfig(
      emoji: '❤️',
      badgeColor: Colors.pink.shade400,
      avatarColor: Colors.pink.shade100,
      buildTitle: (newsTitle, boldStyle, normalStyle) => Text(
        newsTitle,
        style: normalStyle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  };

  /// الواجهة الوحيدة للخارج
  static NotificationTypeConfig of(String type) {
    return _configs[type] ?? _configs['default']!;
  }
}