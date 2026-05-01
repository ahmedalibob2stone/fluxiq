import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../core/router/app_route_names.dart.dart';
import '../core/widgets/empty_notifications.dart';
import '../core/widgets/error_notification_widget.dart';
import 'widgets/notification_title.dart';
import '../providers/vm/notification_vm_provider.dart';

import 'widgets/notifications_app_bar.dart';
class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('en', null);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationVmProvider);
    final vm = ref.read(notificationVmProvider.notifier);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final horizontalPadding = screenWidth > 600 ? screenWidth * 0.08 : 0.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NotificationsAppBar(
        state: state,
        vm: vm,
        onBack: () => context.pop(),
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              );
            }

            if (state.errorMessage != null && state.notifications.isEmpty) {
              return ErrorNotifications(
                message: state.errorMessage!,
                onRetry: () {},
              );
            }

            if (state.notifications.isEmpty) {
              return const EmptyNotifications();
            }

            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
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
                    context.pushNamed(
                      AppRouteNames.notificationNewsDetails,
                      pathParameters: {'newsId': notification.newsId},
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
