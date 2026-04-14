
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/widgets/empty_notifications.dart';
import '../core/widgets/notification_title.dart';
import '../providers/vm/notification_vm_provider.dart';


class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationVmProvider);
    final vm = ref.read(notificationVmProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('الإشعارات'),
        actions: [
          if (state.unreadCount > 0)
            TextButton(
              onPressed: vm.markAllAsRead,
              child: const Text(
                'تحديد الكل',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.notifications.isEmpty
          ? const EmptyNotifications()
          : ListView.separated(
        itemCount: state.notifications.length,
        separatorBuilder: (_, __) =>
        const Divider(height: 1, indent: 70),
        itemBuilder: (context, index) {
          final notification = state.notifications[index];
          return NotificationTile(
            key: ValueKey(notification.id),
            notification: notification,
            onTap: () {
              if (!notification.isRead) {
                vm.markAsRead(notification.id);
              }
              context.push('/news/${notification.newsId}');
            },
          );
        },
      ),
    );
  }
}