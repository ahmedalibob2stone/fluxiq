import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../core/router/app_route_names.dart.dart';
import '../core/widgets/empty_notifications.dart';
import '../core/widgets/error_notification_widget.dart';
import 'widgets/notification_title.dart';
import '../providers/vm/notification_vm_provider.dart';
import '../state/notification_state.dart';
import '../viewmodels/notification_viewmodel.dart';


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
    ref.listen<NotificationState>(notificationVmProvider, (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage &&
          next.notifications.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    final state = ref.watch(notificationVmProvider);
    final vm = ref.read(notificationVmProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => context.pop(),
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
      ),
      body: SafeArea(
        child: _buildBody(context, state, vm),
      ),
    );
  }

  Widget _buildBody(
      BuildContext context,
      NotificationState state,
      NotificationViewModel vm,
      ) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    final horizontalPadding = screenWidth > 600 ? screenWidth * 0.08 : 0.0;

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
      separatorBuilder: (_, __) => const Divider(height: 1, indent: 70),
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
  }
}