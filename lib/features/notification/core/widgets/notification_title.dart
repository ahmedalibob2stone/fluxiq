// lib/core/widgets/notification_tile.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/notification_model.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: notification.isRead ? Colors.white : Colors.blue.shade50,
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: _avatarColor(),
        child: Text(
          _avatarEmoji(),
          style: const TextStyle(fontSize: 18),
        ),
      ),
      title: Text(
        _buildTitle(),
        style: TextStyle(
          fontWeight:
          notification.isRead ? FontWeight.normal : FontWeight.bold,
          fontSize: 14,
        ),
      ),
      subtitle: Text(
        DateFormat('dd MMM · hh:mm a', 'ar').format(notification.createdAt),
        style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
      ),
      trailing: notification.isRead
          ? null
          : Container(
        width: 10,
        height: 10,
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  String _avatarEmoji() {
    switch (notification.type) {
      case 'breaking_news':
        return '📰';
      case 'milestone':
        return '🎉';
      default:
        return '❤️';
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

  String _buildTitle() {
    switch (notification.type) {
      case 'like':
        return '${notification.senderUsername} أعجب بخبرك: ${notification.newsTitle}';
      case 'milestone':
        return '🎉 وصل خبرك "${notification.newsTitle}" لعدد إعجابات مميز!';
      case 'breaking_news':
        return '🔴 خبر عاجل: ${notification.newsTitle}';
      default:
        return notification.newsTitle;
    }
  }
}