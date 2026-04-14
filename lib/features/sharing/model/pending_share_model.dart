class CacheShareModel {
  final String shareId;
  final String newsId;
  final String userId;
  final String platform;
  final DateTime sharedAt;

  const CacheShareModel({
    required this.shareId,
    required this.newsId,
    required this.userId,
    required this.platform,
    required this.sharedAt,
  });

  Map<String, dynamic> toJson() => {
    'shareId': shareId,
    'newsId': newsId,
    'userId': userId,
    'platform': platform,
    'sharedAt': sharedAt.toIso8601String(),
  };

  factory CacheShareModel.fromJson(Map<String, dynamic> json) {
    return CacheShareModel(
      shareId: json['shareId'] as String,
      newsId: json['newsId'] as String,
      userId: json['userId'] as String,
      platform: json['platform'] as String,
      sharedAt: DateTime.parse(json['sharedAt'] as String),
    );
  }
}