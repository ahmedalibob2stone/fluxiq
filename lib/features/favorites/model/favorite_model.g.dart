// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FavoriteModelImpl _$$FavoriteModelImplFromJson(Map<String, dynamic> json) =>
    _$FavoriteModelImpl(
      newsId: json['newsId'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      category: json['category'] as String,
      userId: json['userId'] as String,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Object),
    );

Map<String, dynamic> _$$FavoriteModelImplToJson(_$FavoriteModelImpl instance) =>
    <String, dynamic>{
      'newsId': instance.newsId,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'category': instance.category,
      'userId': instance.userId,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
