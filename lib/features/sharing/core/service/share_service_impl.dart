import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'share_service.dart';

class ShareServiceImpl implements ShareService {
  @override
  Future<void> shareText(String text) async {
    await Share.share(text);
  }

  @override
  Future<void> shareToTelegram(String link, String title) async {
    final url = Uri.parse(
      "https://t.me/share/url?url=$link&text=${Uri.encodeComponent(title)}",
    );
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Future<void> shareToFacebook(String link) async {
    final url = Uri.parse(
      "https://www.facebook.com/sharer/sharer.php?u=$link",
    );
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Future<void> copyLink(String link) async {
    await Clipboard.setData(ClipboardData(text: link));
  }
}