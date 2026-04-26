import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_model.freezed.dart';
part 'news_model.g.dart';

@freezed
class NewsModel with _$NewsModel {
  const factory NewsModel({
    required String newsId,
    required String title,
    required String imageUrl,
    required String category,
      required String des,
    required DateTime createdAt,
    required bool isBreaking,
    required String? userId,
    required bool isUserPost,
    @Default('user') String authorRole,
    @Default(0) int viewsCount,
    @Default(0) int likesCount,
    @Default(0) int favoritesCount,
    @Default(0) int totalShares,
    String? sourceUrl,
    String? source,
  }) = _NewsModel;

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);
}