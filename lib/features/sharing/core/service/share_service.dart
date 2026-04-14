abstract class ShareService {
  Future<void> shareText(String text);
  Future<void> shareToTelegram(String link, String title);
  Future<void> shareToFacebook(String link);
  Future<void> copyLink(String link);
}