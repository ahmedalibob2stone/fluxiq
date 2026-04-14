// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewsViewModelModelImpl _$$NewsViewModelModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NewsViewModelModelImpl(
      viewedAt: DateTime.parse(json['viewedAt'] as String),
      ip: json['ip'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
    );

Map<String, dynamic> _$$NewsViewModelModelImplToJson(
        _$NewsViewModelModelImpl instance) =>
    <String, dynamic>{
      'viewedAt': instance.viewedAt.toIso8601String(),
      'ip': instance.ip,
      'country': instance.country,
      'city': instance.city,
    };
