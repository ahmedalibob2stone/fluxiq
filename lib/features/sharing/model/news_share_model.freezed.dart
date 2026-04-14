// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_share_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NewsShareModel _$NewsShareModelFromJson(Map<String, dynamic> json) {
  return _NewsShareModel.fromJson(json);
}

/// @nodoc
mixin _$NewsShareModel {
  String get shareId => throw _privateConstructorUsedError;
  DateTime get sharedAt => throw _privateConstructorUsedError;
  String get platform => throw _privateConstructorUsedError;

  /// Serializes this NewsShareModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NewsShareModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NewsShareModelCopyWith<NewsShareModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsShareModelCopyWith<$Res> {
  factory $NewsShareModelCopyWith(
          NewsShareModel value, $Res Function(NewsShareModel) then) =
      _$NewsShareModelCopyWithImpl<$Res, NewsShareModel>;
  @useResult
  $Res call({String shareId, DateTime sharedAt, String platform});
}

/// @nodoc
class _$NewsShareModelCopyWithImpl<$Res, $Val extends NewsShareModel>
    implements $NewsShareModelCopyWith<$Res> {
  _$NewsShareModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NewsShareModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shareId = null,
    Object? sharedAt = null,
    Object? platform = null,
  }) {
    return _then(_value.copyWith(
      shareId: null == shareId
          ? _value.shareId
          : shareId // ignore: cast_nullable_to_non_nullable
              as String,
      sharedAt: null == sharedAt
          ? _value.sharedAt
          : sharedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewsShareModelImplCopyWith<$Res>
    implements $NewsShareModelCopyWith<$Res> {
  factory _$$NewsShareModelImplCopyWith(_$NewsShareModelImpl value,
          $Res Function(_$NewsShareModelImpl) then) =
      __$$NewsShareModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String shareId, DateTime sharedAt, String platform});
}

/// @nodoc
class __$$NewsShareModelImplCopyWithImpl<$Res>
    extends _$NewsShareModelCopyWithImpl<$Res, _$NewsShareModelImpl>
    implements _$$NewsShareModelImplCopyWith<$Res> {
  __$$NewsShareModelImplCopyWithImpl(
      _$NewsShareModelImpl _value, $Res Function(_$NewsShareModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of NewsShareModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shareId = null,
    Object? sharedAt = null,
    Object? platform = null,
  }) {
    return _then(_$NewsShareModelImpl(
      shareId: null == shareId
          ? _value.shareId
          : shareId // ignore: cast_nullable_to_non_nullable
              as String,
      sharedAt: null == sharedAt
          ? _value.sharedAt
          : sharedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NewsShareModelImpl implements _NewsShareModel {
  const _$NewsShareModelImpl(
      {required this.shareId, required this.sharedAt, required this.platform});

  factory _$NewsShareModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewsShareModelImplFromJson(json);

  @override
  final String shareId;
  @override
  final DateTime sharedAt;
  @override
  final String platform;

  @override
  String toString() {
    return 'NewsShareModel(shareId: $shareId, sharedAt: $sharedAt, platform: $platform)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsShareModelImpl &&
            (identical(other.shareId, shareId) || other.shareId == shareId) &&
            (identical(other.sharedAt, sharedAt) ||
                other.sharedAt == sharedAt) &&
            (identical(other.platform, platform) ||
                other.platform == platform));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, shareId, sharedAt, platform);

  /// Create a copy of NewsShareModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsShareModelImplCopyWith<_$NewsShareModelImpl> get copyWith =>
      __$$NewsShareModelImplCopyWithImpl<_$NewsShareModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NewsShareModelImplToJson(
      this,
    );
  }
}

abstract class _NewsShareModel implements NewsShareModel {
  const factory _NewsShareModel(
      {required final String shareId,
      required final DateTime sharedAt,
      required final String platform}) = _$NewsShareModelImpl;

  factory _NewsShareModel.fromJson(Map<String, dynamic> json) =
      _$NewsShareModelImpl.fromJson;

  @override
  String get shareId;
  @override
  DateTime get sharedAt;
  @override
  String get platform;

  /// Create a copy of NewsShareModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewsShareModelImplCopyWith<_$NewsShareModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
