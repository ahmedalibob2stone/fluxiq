import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../news/model/news_model.dart';
import '../provider/vm/new_sharing_vm_provider.dart';

class ShareOptionsWidget extends ConsumerWidget {
  final NewsModel news;

  const ShareOptionsWidget({super.key, required this.news});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                "Share",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.copy),
              title: const Text("Copy Link"),
              onTap: () => ref
                  .read(shareViewModelProvider.notifier)
                  .share(news: news, platform: "CopyLink"),
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text("Share"),
              onTap: () => ref
                  .read(shareViewModelProvider.notifier)
                  .share(news: news, platform: "Other"),
            ),
          ],
        ),
      ),
    );
  }
}