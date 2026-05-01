import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxiq/features/news/screens/home/widgets/search_news_delegate.dart';

import '../../notifications/widgets/notification_bell.dart';


class NewsHomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const NewsHomeAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
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
      ),
      title: const Text(
        'FluxIQ',
        style: TextStyle(
          fontFamily: 'MyCustomFont',
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 26,
          letterSpacing: 1.2,
        ),
      ),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () => showSearch(
            context: context,
            delegate: SearchNewsDelegate(ref),
          ),
        ),
        const NotificationBell(),
      ],
    );
  }
}