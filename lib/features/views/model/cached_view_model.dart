import 'dart:convert';

class CachedViewModel {
  final String newsId;
  final String userId;
  final String viewedAt;

  const CachedViewModel({
    required this.newsId,
    required this.userId,
    required this.viewedAt,
  });

  Map<String, dynamic> toJson() => {
    'newsId': newsId,
    'userId': userId,
    'viewedAt': viewedAt,
  };

  factory CachedViewModel.fromJson(Map<String, dynamic> json) {
    return CachedViewModel(
      newsId: json['newsId'] as String,
      userId: json['userId'] as String,
      viewedAt: json['viewedAt'] as String,
    );
  }

  String toEncodedString() => jsonEncode(toJson());

  factory CachedViewModel.fromEncodedString(String encoded) =>
      CachedViewModel.fromJson(jsonDecode(encoded) as Map<String, dynamic>);
}