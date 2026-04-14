// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FavoriteModel _$FavoriteModelFromJson(Map<String, dynamic> json) {
  return _FavoriteModel.fromJson(json);
}

/// @nodoc
mixin _$FavoriteModel {
  String get newsId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this FavoriteModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FavoriteModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FavoriteModelCopyWith<FavoriteModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteModelCopyWith<$Res> {
  factory $FavoriteModelCopyWith(
          FavoriteModel value, $Res Function(FavoriteModel) then) =
      _$FavoriteModelCopyWithImpl<$Res, FavoriteModel>;
  @useResult
  $Res call(
      {String newsId,
      String title,
      String imageUrl,
      String category,
      String userId,
      @TimestampConverter() DateTime createdAt});
}

/// @nodoc
class _$FavoriteModelCopyWithImpl<$Res, $Val extends FavoriteModel>
    implements $FavoriteModelCopyWith<$Res> {
  _$FavoriteModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoriteModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newsId = null,
    Object? title = null,
    Object? imageUrl = null,
    Object? category = null,
    Object? userId = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      newsId: null == newsId
          ? _value.newsId
          : newsId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FavoriteModelImplCopyWith<$Res>
    implements $FavoriteModelCopyWith<$Res> {
  factory _$$FavoriteModelImplCopyWith(
          _$FavoriteModelImpl value, $Res Function(_$FavoriteModelImpl) then) =
      __$$FavoriteModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String newsId,
      String title,
      String imageUrl,
      String category,
      String userId,
      @TimestampConverter() DateTime createdAt});
}

/// @nodoc
class __$$FavoriteModelImplCopyWithImpl<$Res>
    extends _$FavoriteModelCopyWithImpl<$Res, _$FavoriteModelImpl>
    implements _$$FavoriteModelImplCopyWith<$Res> {
  __$$FavoriteModelImplCopyWithImpl(
      _$FavoriteModelImpl _value, $Res Function(_$FavoriteModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoriteModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newsId = null,
    Object? title = null,
    Object? imageUrl = null,
    Object? category = null,
    Object? userId = null,
    Object? createdAt = null,
  }) {
    return _then(_$FavoriteModelImpl(
      newsId: null == newsId
          ? _value.newsId
          : newsId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FavoriteModelImpl implements _FavoriteModel {
  const _$FavoriteModelImpl(
      {required this.newsId,
      required this.title,
      required this.imageUrl,
      required this.category,
      required this.userId,
      @TimestampConverter() required this.createdAt});

  factory _$FavoriteModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FavoriteModelImplFromJson(json);

  @override
  final String newsId;
  @override
  final String title;
  @override
  final String imageUrl;
  @override
  final String category;
  @override
  final String userId;
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'FavoriteModel(newsId: $newsId, title: $title, imageUrl: $imageUrl, category: $category, userId: $userId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoriteModelImpl &&
            (identical(other.newsId, newsId) || other.newsId == newsId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, newsId, title, imageUrl, category, userId, createdAt);

  /// Create a copy of FavoriteModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoriteModelImplCopyWith<_$FavoriteModelImpl> get copyWith =>
      __$$FavoriteModelImplCopyWithImpl<_$FavoriteModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FavoriteModelImplToJson(
      this,
    );
  }
}

abstract class _FavoriteModel implements FavoriteModel {
  const factory _FavoriteModel(
          {required final String newsId,
          required final String title,
          required final String imageUrl,
          required final String category,
          required final String userId,
          @TimestampConverter() required final DateTime createdAt}) =
      _$FavoriteModelImpl;

  factory _FavoriteModel.fromJson(Map<String, dynamic> json) =
      _$FavoriteModelImpl.fromJson;

  @override
  String get newsId;
  @override
  String get title;
  @override
  String get imageUrl;
  @override
  String get category;
  @override
  String get userId;
  @override
  @TimestampConverter()
  DateTime get createdAt;

  /// Create a copy of FavoriteModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoriteModelImplCopyWith<_$FavoriteModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
