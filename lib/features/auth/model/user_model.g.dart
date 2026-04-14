// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      name: json['name'] as String,
      uid: json['uid'] as String,
      email: json['email'] as String,
      isBanned: json['isBanned'] as bool? ?? false,
      role: json['role'] as String? ?? 'user',
      favoritesCount: (json['favoritesCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'uid': instance.uid,
      'email': instance.email,
      'isBanned': instance.isBanned,
      'role': instance.role,
      'favoritesCount': instance.favoritesCount,
    };
