// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LikeModelImpl _$$LikeModelImplFromJson(Map<String, dynamic> json) =>
    _$LikeModelImpl(
      newsId: json['newsId'] as String,
      newsTitle: json['newsTitle'] as String,
      newsDescription: json['newsDescription'] as String,
      newsImageUrl: json['newsImageUrl'] as String,
      newsUserId: json['newsUserId'] as String,
      likedAt: DateTime.parse(json['likedAt'] as String),
      category: json['category'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$LikeModelImplToJson(_$LikeModelImpl instance) =>
    <String, dynamic>{
      'newsId': instance.newsId,
      'newsTitle': instance.newsTitle,
      'newsDescription': instance.newsDescription,
      'newsImageUrl': instance.newsImageUrl,
      'newsUserId': instance.newsUserId,
      'likedAt': instance.likedAt.toIso8601String(),
      'category': instance.category,
      'email': instance.email,
      'name': instance.name,
    };
