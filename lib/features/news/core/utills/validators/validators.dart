class Validators {
  static bool isValidImageUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasAbsolutePath) return false;
    final lowerUrl = url.toLowerCase();
    if (!lowerUrl.startsWith('http')) return false;
    return lowerUrl.endsWith('.jpg') ||
        lowerUrl.endsWith('.jpeg') ||
        lowerUrl.endsWith('.png') ||
        lowerUrl.endsWith('.webp');
  }

  static String? validatePublishFields({
    required String title,
    required String description,
    required String imageUrl,
    required String? category,
  }) {
    if (title.trim().isEmpty ||
        description.trim().isEmpty ||
        imageUrl.trim().isEmpty ||
        category == null || category.trim().isEmpty) {
      return "All fields are required";
    }
    if (!isValidImageUrl(imageUrl.trim())) {
      return 'Please enter a valid direct image URL (.jpg, .png, .webp)';
    }
    return null;
  }
}

