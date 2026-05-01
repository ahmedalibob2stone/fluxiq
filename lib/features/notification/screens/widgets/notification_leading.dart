import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../core/utils/notification_type_config.dart';
import '../../model/notification_model.dart';

class NotificationLeading extends StatelessWidget {
  final NotificationModel notification;
  final double size;

  const NotificationLeading({
    super.key,
    required this.notification,
    this.size = 54.0,
  });

  @override
  Widget build(BuildContext context) {
    final config = NotificationTypeConfig.of(notification.type);
    final hasImage = notification.newsImageUrl.isNotEmpty;
    final badgeSize = size * 0.37;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(size * 0.18),
          child: hasImage
              ? CachedNetworkImage(
            imageUrl: notification.newsImageUrl,
            width: size,
            height: size,
            fit: BoxFit.cover,
            placeholder: (_, __) => _buildPlaceholder(size, config),
            errorWidget: (_, __, ___) => _buildPlaceholder(size, config),
          )
              : _buildPlaceholder(size, config),
        ),
        Positioned(
          bottom: -4,
          right: -4,
          child: Container(
            width: badgeSize,
            height: badgeSize,
            decoration: BoxDecoration(
              color: config.badgeColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
            child: Center(
              child: Text(
                config.emoji,
                style: TextStyle(fontSize: badgeSize * 0.5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder(double size, NotificationTypeConfig config) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: config.avatarColor,
        borderRadius: BorderRadius.circular(size * 0.18),
      ),
      child: Center(
        child: Text(
          config.emoji,
          style: TextStyle(fontSize: size * 0.44),
        ),
      ),
    );
  }
}