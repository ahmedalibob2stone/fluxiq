import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_route_names.dart.dart';
import '../provider/auth_viewmodel_provider.dart';
import '../state/auth_state.dart';
class FluxIQSplashScreen extends ConsumerStatefulWidget {
  const FluxIQSplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FluxIQSplashScreen> createState() =>
      _FluxIQSplashScreenState();
}

class _FluxIQSplashScreenState extends ConsumerState<FluxIQSplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initApp();
    });
  }

  Future<void> _initApp() async {
    try {
      await Future.wait([
        ref.read(authViewModelProvider.notifier).checkUser(),
        Future.delayed(const Duration(seconds: 2)),
      ]);
    } catch (e) {
      debugPrint("Error initializing app: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authViewModelProvider, (prev, next) {
      if (!mounted) return;

      if (next.status == AuthStatus.authenticated) {
        context.goNamed(AppRouteNames.home);
      } else if (next.status == AuthStatus.unauthenticated) {
        context.goNamed(AppRouteNames.onboarding);
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/splash_screen.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  "Loading...",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}