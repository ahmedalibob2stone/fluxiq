// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewsModelImpl _$$NewsModelImplFromJson(Map<String, dynamic> json) =>
    _$NewsModelImpl(
      newsId: json['newsId'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      category: json['category'] as String,
      des: json['des'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isBreaking: json['isBreaking'] as bool,
      userId: json['userId'] as String?,
      isUserPost: json['isUserPost'] as bool,
      authorRole: json['authorRole'] as String? ?? 'user',
      viewsCount: (json['viewsCount'] as num?)?.toInt() ?? 0,
      likesCount: (json['likesCount'] as num?)?.toInt() ?? 0,
      favoritesCount: (json['favoritesCount'] as num?)?.toInt() ?? 0,
      totalShares: (json['totalShares'] as num?)?.toInt() ?? 0,
      sourceUrl: json['sourceUrl'] as String?,
      source: json['source'] as String?,
    );

Map<String, dynamic> _$$NewsModelImplToJson(_$NewsModelImpl instance) =>
    <String, dynamic>{
      'newsId': instance.newsId,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'category': instance.category,
      'des': instance.des,
      'createdAt': instance.createdAt.toIso8601String(),
      'isBreaking': instance.isBreaking,
      'userId': instance.userId,
      'isUserPost': instance.isUserPost,
      'authorRole': instance.authorRole,
      'viewsCount': instance.viewsCount,
      'likesCount': instance.likesCount,
      'favoritesCount': instance.favoritesCount,
      'totalShares': instance.totalShares,
      'sourceUrl': instance.sourceUrl,
      'source': instance.source,
    };
