import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            placeholder: (_, __) => _buildPlaceholder(size),
            errorWidget: (_, __, ___) => _buildPlaceholder(size),
          )
              : _buildPlaceholder(size),
        ),
        Positioned(
          bottom: -4,
          right: -4,
          child: Container(
            width: badgeSize,
            height: badgeSize,
            decoration: BoxDecoration(
              color: _badgeColor(),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
            child: Center(
              child: Text(
                _badgeEmoji(),
                style: TextStyle(fontSize: badgeSize * 0.5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _avatarColor(),
        borderRadius: BorderRadius.circular(size * 0.18),
      ),
      child: Center(
        child: Text(
          _badgeEmoji(),
          style: TextStyle(fontSize: size * 0.44),
        ),
      ),
    );
  }

  String _badgeEmoji() {
    switch (notification.type) {
      case 'breaking_news':
        return '📰';
      case 'milestone':
        return '🎉';
      case 'like':
      default:
        return '❤️';
    }
  }

  Color _badgeColor() {
    switch (notification.type) {
      case 'breaking_news':
        return Colors.red.shade400;
      case 'milestone':
        return Colors.amber.shade400;
      case 'like':
      default:
        return Colors.pink.shade400;
    }
  }

  Color _avatarColor() {
    switch (notification.type) {
      case 'breaking_news':
        return Colors.red.shade100;
      case 'milestone':
        return Colors.amber.shade100;
      default:
        return Colors.pink.shade100;
    }
  }
}