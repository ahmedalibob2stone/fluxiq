import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/utils/notification_type_config.dart';
import '../../model/notification_model.dart';
import 'notification_leading.dart';

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
    final screenWidth = MediaQuery.sizeOf(context).width;
    final fontSize = screenWidth > 600 ? 15.0 : 14.0;

    return ListTile(
      tileColor: notification.isRead ? Colors.white : Colors.blue.shade50,
      onTap: onTap,
      leading: NotificationLeading(
        notification: notification,
        size: screenWidth > 600 ? 64.0 : 54.0,
      ),
      title: _buildTitleWidget(fontSize),
      subtitle: Text(
        DateFormat('dd MMM · hh:mm a', 'en').format(notification.createdAt),
        style: TextStyle(
          color: Colors.grey.shade500,
          fontSize: screenWidth > 600 ? 13.0 : 12.0,
        ),
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

  Widget _buildTitleWidget(double fontSize) {
    final TextStyle boldStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
      color: Colors.black87,
    );

    final TextStyle normalTitleStyle = TextStyle(
      fontSize: fontSize,
      color: Colors.black87,
      fontWeight: FontWeight.normal,
    );

    final config = NotificationTypeConfig.of(notification.type); // ← بدل switch كامل
    return config.buildTitle(notification.newsTitle, boldStyle, normalTitleStyle);
  }}