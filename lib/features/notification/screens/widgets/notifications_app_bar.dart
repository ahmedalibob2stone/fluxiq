import 'package:flutter/material.dart';

import '../../state/notification_state.dart';
import '../../viewmodels/notification_viewmodel.dart';

class NotificationsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final NotificationState state;
  final NotificationViewModel vm;
  final VoidCallback onBack;

  const NotificationsAppBar({
    super.key,
    required this.state,
    required this.vm,
    required this.onBack,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: onBack,
      ),
      title: const Text(
        'Notifications',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E88E5), Color(0xFF8E24AA)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
      actions: [
        if (state.unreadCount > 0)
          state.isMarkingAllRead
              ? const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
          )
              : TextButton(
            onPressed: vm.markAllAsRead,
            child: const Text(
              'Mark all',
              style: TextStyle(color: Colors.white),
            ),
          ),
      ],
    );
  }
}