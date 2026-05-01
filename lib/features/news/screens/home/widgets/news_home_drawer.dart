import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/router/app_route_names.dart.dart';
import 'logout_dialog.dart';

class NewsHomeDrawer extends ConsumerWidget {
  const NewsHomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1E88E5),
                    Color(0xFF8E24AA),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Text(
                "Menu",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.bookmark, color: Colors.amber),
              title: const Text("Favorites"),
              onTap: () {
                context.pop();
                context.pushNamed(AppRouteNames.favorites);
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.red),
              title: const Text("Likes"),
              onTap: () {
                context.pop();
                context.pushNamed(AppRouteNames.liked);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.blue),
              title: const Text(
                "Log Out",
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                context.pop();
                showLogoutDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const LogoutDialog(),
    );
  }
}