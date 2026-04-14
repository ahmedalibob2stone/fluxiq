class ImageUrlSanitizer {
  static String sanitize(String? url) {
    if (url == null) return '';

    final trimmed = url.trim();
    if (trimmed.isEmpty) return '';

    final uri = Uri.tryParse(trimmed);
    if (uri == null) return '';
    if (!(uri.scheme == 'http' || uri.scheme == 'https')) return '';
    if (uri.host.isEmpty) return '';

    final lower = trimmed.toLowerCase();
    if (lower.contains('placeholder.com') || lower.contains('removed')) {
      return '';
    }

    return trimmed;
  }
}