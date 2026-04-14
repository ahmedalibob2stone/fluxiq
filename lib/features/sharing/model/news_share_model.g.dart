// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_share_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewsShareModelImpl _$$NewsShareModelImplFromJson(Map<String, dynamic> json) =>
    _$NewsShareModelImpl(
      shareId: json['shareId'] as String,
      sharedAt: DateTime.parse(json['sharedAt'] as String),
      platform: json['platform'] as String,
    );

Map<String, dynamic> _$$NewsShareModelImplToJson(
        _$NewsShareModelImpl instance) =>
    <String, dynamic>{
      'shareId': instance.shareId,
      'sharedAt': instance.sharedAt.toIso8601String(),
      'platform': instance.platform,
    };
