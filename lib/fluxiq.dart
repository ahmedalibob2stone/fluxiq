import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/provider/current_user_id_provider.dart';
import 'core/provider/share_sync_provider.dart';
import 'core/router/app_router.dart';
import 'core/services/provider/fcm_service_provider.dart';
import 'core/theme/theme_data.dart';
import 'features/notification/providers/vm/notification_vm_provider.dart';
import 'features/views/provider/service/views_sync_provider.dart';

class FluxIQ extends ConsumerWidget {
  const FluxIQ({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    ref.listen<String?>(currentUserIdProvider, (previous, next) {
      if (next != null && next.isNotEmpty && previous != next) {
        ref.read(fcmServiceProvider).initialize();
        debugPrint('[Main] FCM initialized for user: $next');
      }
    });

    final userId = ref.watch(currentUserIdProvider);
    if (userId != null && userId.isNotEmpty) {
      ref.watch(notificationVmProvider);
    }

    ref.watch(viewsSyncProvider);
    ref.watch(shareSyncProvider);

    return MaterialApp.router(
      title: 'FluxIQ News',
      routerConfig: ref.watch(appRouterProvider),
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}