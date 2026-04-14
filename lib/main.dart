import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/provider/fcm_service_provider.dart';
import 'core/provider/share_sync_provider.dart';
import 'core/provider/shared_preference_provider.dart';
import 'core/router/app_router.dart';
import 'core/services/fcm_token_service.dart';
import 'core/theme/theme_data.dart';


import 'features/notification/providers/vm/notification_vm_provider.dart';
import 'features/views/provider/service/views_sync_provider.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    final isImageError = details.library == 'image resource service';
    if (isImageError) {

      return;
    }
    FlutterError.presentError(details);
  };
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const FluxIQ(),
    ),);
}

class FluxIQ extends ConsumerWidget {
  const FluxIQ({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(viewsSyncProvider);
    ref.watch(shareSyncProvider);
    ref.listen<String?>(currentUserIdProvider, (previous, next) {
      if (next != null && next.isNotEmpty && previous != next) {
        ref.read(fcmServiceProvider).initialize();
      }
    });

    final userId = ref.watch(currentUserIdProvider);
    if (userId != null && userId.isNotEmpty) {
      ref.read(notificationVmProvider);
    }
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'FluxIQ News',
      routerConfig: router,

      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}
