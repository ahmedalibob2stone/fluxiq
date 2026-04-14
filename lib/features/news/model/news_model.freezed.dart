// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) {
  return _NewsModel.fromJson(json);
}

/// @nodoc
mixin _$NewsModel {
  String get newsId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get des => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get isBreaking => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  bool get isUserPost => throw _privateConstructorUsedError;
  String get authorRole => throw _privateConstructorUsedError;
  int get viewsCount => throw _privateConstructorUsedError;
  int get likesCount => throw _privateConstructorUsedError;
  int get favoritesCount => throw _privateConstructorUsedError;
  int get totalShares => throw _privateConstructorUsedError;
  String? get sourceUrl => throw _privateConstructorUsedError;
  String? get source => throw _privateConstructorUsedError;

  /// Serializes this NewsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NewsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NewsModelCopyWith<NewsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsModelCopyWith<$Res> {
  factory $NewsModelCopyWith(NewsModel value, $Res Function(NewsModel) then) =
      _$NewsModelCopyWithImpl<$Res, NewsModel>;
  @useResult
  $Res call(
      {String newsId,
      String title,
      String imageUrl,
      String category,
      String des,
      DateTime createdAt,
      bool isBreaking,
      String? userId,
      bool isUserPost,
      String authorRole,
      int viewsCount,
      int likesCount,
      int favoritesCount,
      int totalShares,
      String? sourceUrl,
      String? source});
}

/// @nodoc
class _$NewsModelCopyWithImpl<$Res, $Val extends NewsModel>
    implements $NewsModelCopyWith<$Res> {
  _$NewsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NewsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newsId = null,
    Object? title = null,
    Object? imageUrl = null,
    Object? category = null,
    Object? des = null,
    Object? createdAt = null,
    Object? isBreaking = null,
    Object? userId = freezed,
    Object? isUserPost = null,
    Object? authorRole = null,
    Object? viewsCount = null,
    Object? likesCount = null,
    Object? favoritesCount = null,
    Object? totalShares = null,
    Object? sourceUrl = freezed,
    Object? source = freezed,
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
      des: null == des
          ? _value.des
          : des // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isBreaking: null == isBreaking
          ? _value.isBreaking
          : isBreaking // ignore: cast_nullable_to_non_nullable
              as bool,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      isUserPost: null == isUserPost
          ? _value.isUserPost
          : isUserPost // ignore: cast_nullable_to_non_nullable
              as bool,
      authorRole: null == authorRole
          ? _value.authorRole
          : authorRole // ignore: cast_nullable_to_non_nullable
              as String,
      viewsCount: null == viewsCount
          ? _value.viewsCount
          : viewsCount // ignore: cast_nullable_to_non_nullable
              as int,
      likesCount: null == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int,
      favoritesCount: null == favoritesCount
          ? _value.favoritesCount
          : favoritesCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalShares: null == totalShares
          ? _value.totalShares
          : totalShares // ignore: cast_nullable_to_non_nullable
              as int,
      sourceUrl: freezed == sourceUrl
          ? _value.sourceUrl
          : sourceUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewsModelImplCopyWith<$Res>
    implements $NewsModelCopyWith<$Res> {
  factory _$$NewsModelImplCopyWith(
          _$NewsModelImpl value, $Res Function(_$NewsModelImpl) then) =
      __$$NewsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String newsId,
      String title,
      String imageUrl,
      String category,
      String des,
      DateTime createdAt,
      bool isBreaking,
      String? userId,
      bool isUserPost,
      String authorRole,
      int viewsCount,
      int likesCount,
      int favoritesCount,
      int totalShares,
      String? sourceUrl,
      String? source});
}

/// @nodoc
class __$$NewsModelImplCopyWithImpl<$Res>
    extends _$NewsModelCopyWithImpl<$Res, _$NewsModelImpl>
    implements _$$NewsModelImplCopyWith<$Res> {
  __$$NewsModelImplCopyWithImpl(
      _$NewsModelImpl _value, $Res Function(_$NewsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of NewsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newsId = null,
    Object? title = null,
    Object? imageUrl = null,
    Object? category = null,
    Object? des = null,
    Object? createdAt = null,
    Object? isBreaking = null,
    Object? userId = freezed,
    Object? isUserPost = null,
    Object? authorRole = null,
    Object? viewsCount = null,
    Object? likesCount = null,
    Object? favoritesCount = null,
    Object? totalShares = null,
    Object? sourceUrl = freezed,
    Object? source = freezed,
  }) {
    return _then(_$NewsModelImpl(
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
      des: null == des
          ? _value.des
          : des // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isBreaking: null == isBreaking
          ? _value.isBreaking
          : isBreaking // ignore: cast_nullable_to_non_nullable
              as bool,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      isUserPost: null == isUserPost
          ? _value.isUserPost
          : isUserPost // ignore: cast_nullable_to_non_nullable
              as bool,
      authorRole: null == authorRole
          ? _value.authorRole
          : authorRole // ignore: cast_nullable_to_non_nullable
              as String,
      viewsCount: null == viewsCount
          ? _value.viewsCount
          : viewsCount // ignore: cast_nullable_to_non_nullable
              as int,
      likesCount: null == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int,
      favoritesCount: null == favoritesCount
          ? _value.favoritesCount
          : favoritesCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalShares: null == totalShares
          ? _value.totalShares
          : totalShares // ignore: cast_nullable_to_non_nullable
              as int,
      sourceUrl: freezed == sourceUrl
          ? _value.sourceUrl
          : sourceUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NewsModelImpl implements _NewsModel {
  const _$NewsModelImpl(
      {required this.newsId,
      required this.title,
      required this.imageUrl,
      required this.category,
      required this.des,
      required this.createdAt,
      required this.isBreaking,
      required this.userId,
      required this.isUserPost,
      this.authorRole = 'user',
      this.viewsCount = 0,
      this.likesCount = 0,
      this.favoritesCount = 0,
      this.totalShares = 0,
      this.sourceUrl,
      this.source});

  factory _$NewsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewsModelImplFromJson(json);

  @override
  final String newsId;
  @override
  final String title;
  @override
  final String imageUrl;
  @override
  final String category;
  @override
  final String des;
  @override
  final DateTime createdAt;
  @override
  final bool isBreaking;
  @override
  final String? userId;
  @override
  final bool isUserPost;
  @override
  @JsonKey()
  final String authorRole;
  @override
  @JsonKey()
  final int viewsCount;
  @override
  @JsonKey()
  final int likesCount;
  @override
  @JsonKey()
  final int favoritesCount;
  @override
  @JsonKey()
  final int totalShares;
  @override
  final String? sourceUrl;
  @override
  final String? source;

  @override
  String toString() {
    return 'NewsModel(newsId: $newsId, title: $title, imageUrl: $imageUrl, category: $category, des: $des, createdAt: $createdAt, isBreaking: $isBreaking, userId: $userId, isUserPost: $isUserPost, authorRole: $authorRole, viewsCount: $viewsCount, likesCount: $likesCount, favoritesCount: $favoritesCount, totalShares: $totalShares, sourceUrl: $sourceUrl, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsModelImpl &&
            (identical(other.newsId, newsId) || other.newsId == newsId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.des, des) || other.des == des) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isBreaking, isBreaking) ||
                other.isBreaking == isBreaking) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.isUserPost, isUserPost) ||
                other.isUserPost == isUserPost) &&
            (identical(other.authorRole, authorRole) ||
                other.authorRole == authorRole) &&
            (identical(other.viewsCount, viewsCount) ||
                other.viewsCount == viewsCount) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.favoritesCount, favoritesCount) ||
                other.favoritesCount == favoritesCount) &&
            (identical(other.totalShares, totalShares) ||
                other.totalShares == totalShares) &&
            (identical(other.sourceUrl, sourceUrl) ||
                other.sourceUrl == sourceUrl) &&
            (identical(other.source, source) || other.source == source));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      newsId,
      title,
      imageUrl,
      category,
      des,
      createdAt,
      isBreaking,
      userId,
      isUserPost,
      authorRole,
      viewsCount,
      likesCount,
      favoritesCount,
      totalShares,
      sourceUrl,
      source);

  /// Create a copy of NewsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsModelImplCopyWith<_$NewsModelImpl> get copyWith =>
      __$$NewsModelImplCopyWithImpl<_$NewsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NewsModelImplToJson(
      this,
    );
  }
}

abstract class _NewsModel implements NewsModel {
  const factory _NewsModel(
      {required final String newsId,
      required final String title,
      required final String imageUrl,
      required final String category,
      required final String des,
      required final DateTime createdAt,
      required final bool isBreaking,
      required final String? userId,
      required final bool isUserPost,
      final String authorRole,
      final int viewsCount,
      final int likesCount,
      final int favoritesCount,
      final int totalShares,
      final String? sourceUrl,
      final String? source}) = _$NewsModelImpl;

  factory _NewsModel.fromJson(Map<String, dynamic> json) =
      _$NewsModelImpl.fromJson;

  @override
  String get newsId;
  @override
  String get title;
  @override
  String get imageUrl;
  @override
  String get category;
  @override
  String get des;
  @override
  DateTime get createdAt;
  @override
  bool get isBreaking;
  @override
  String? get userId;
  @override
  bool get isUserPost;
  @override
  String get authorRole;
  @override
  int get viewsCount;
  @override
  int get likesCount;
  @override
  int get favoritesCount;
  @override
  int get totalShares;
  @override
  String? get sourceUrl;
  @override
  String? get source;

  /// Create a copy of NewsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewsModelImplCopyWith<_$NewsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
