import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/vm/notification_news_viewmodel_provider.dart';
import '../state/notification_news_state.dart';
import 'news_details_screen.dart';

class NotificationNewsScreen extends ConsumerStatefulWidget {
  final String newsId;

  const NotificationNewsScreen({required this.newsId, super.key});

  @override
  ConsumerState<NotificationNewsScreen> createState() =>
      _NotificationNewsScreenState();
}

class _NotificationNewsScreenState
    extends ConsumerState<NotificationNewsScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(notificationNewsProvider(widget.newsId).notifier)
          .loadById(widget.newsId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationNewsProvider(widget.newsId));

    if (state.isLoading || state.status == NotificationNewsStatus.initial) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Colors.blue)),
      );
    }

    if (state.hasError) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              state.errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
        ),
      );
    }

    return NewsDetailsScreen(news: state.news!);
  }
}