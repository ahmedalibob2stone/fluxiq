// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NewsViewModelModel _$NewsViewModelModelFromJson(Map<String, dynamic> json) {
  return _NewsViewModelModel.fromJson(json);
}

/// @nodoc
mixin _$NewsViewModelModel {
  DateTime get viewedAt => throw _privateConstructorUsedError;
  String? get ip => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;

  /// Serializes this NewsViewModelModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NewsViewModelModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NewsViewModelModelCopyWith<NewsViewModelModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsViewModelModelCopyWith<$Res> {
  factory $NewsViewModelModelCopyWith(
          NewsViewModelModel value, $Res Function(NewsViewModelModel) then) =
      _$NewsViewModelModelCopyWithImpl<$Res, NewsViewModelModel>;
  @useResult
  $Res call({DateTime viewedAt, String? ip, String? country, String? city});
}

/// @nodoc
class _$NewsViewModelModelCopyWithImpl<$Res, $Val extends NewsViewModelModel>
    implements $NewsViewModelModelCopyWith<$Res> {
  _$NewsViewModelModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NewsViewModelModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? viewedAt = null,
    Object? ip = freezed,
    Object? country = freezed,
    Object? city = freezed,
  }) {
    return _then(_value.copyWith(
      viewedAt: null == viewedAt
          ? _value.viewedAt
          : viewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ip: freezed == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewsViewModelModelImplCopyWith<$Res>
    implements $NewsViewModelModelCopyWith<$Res> {
  factory _$$NewsViewModelModelImplCopyWith(_$NewsViewModelModelImpl value,
          $Res Function(_$NewsViewModelModelImpl) then) =
      __$$NewsViewModelModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime viewedAt, String? ip, String? country, String? city});
}

/// @nodoc
class __$$NewsViewModelModelImplCopyWithImpl<$Res>
    extends _$NewsViewModelModelCopyWithImpl<$Res, _$NewsViewModelModelImpl>
    implements _$$NewsViewModelModelImplCopyWith<$Res> {
  __$$NewsViewModelModelImplCopyWithImpl(_$NewsViewModelModelImpl _value,
      $Res Function(_$NewsViewModelModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of NewsViewModelModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? viewedAt = null,
    Object? ip = freezed,
    Object? country = freezed,
    Object? city = freezed,
  }) {
    return _then(_$NewsViewModelModelImpl(
      viewedAt: null == viewedAt
          ? _value.viewedAt
          : viewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ip: freezed == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NewsViewModelModelImpl implements _NewsViewModelModel {
  const _$NewsViewModelModelImpl(
      {required this.viewedAt, this.ip, this.country, this.city});

  factory _$NewsViewModelModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewsViewModelModelImplFromJson(json);

  @override
  final DateTime viewedAt;
  @override
  final String? ip;
  @override
  final String? country;
  @override
  final String? city;

  @override
  String toString() {
    return 'NewsViewModelModel(viewedAt: $viewedAt, ip: $ip, country: $country, city: $city)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsViewModelModelImpl &&
            (identical(other.viewedAt, viewedAt) ||
                other.viewedAt == viewedAt) &&
            (identical(other.ip, ip) || other.ip == ip) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.city, city) || other.city == city));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, viewedAt, ip, country, city);

  /// Create a copy of NewsViewModelModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsViewModelModelImplCopyWith<_$NewsViewModelModelImpl> get copyWith =>
      __$$NewsViewModelModelImplCopyWithImpl<_$NewsViewModelModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NewsViewModelModelImplToJson(
      this,
    );
  }
}

abstract class _NewsViewModelModel implements NewsViewModelModel {
  const factory _NewsViewModelModel(
      {required final DateTime viewedAt,
      final String? ip,
      final String? country,
      final String? city}) = _$NewsViewModelModelImpl;

  factory _NewsViewModelModel.fromJson(Map<String, dynamic> json) =
      _$NewsViewModelModelImpl.fromJson;

  @override
  DateTime get viewedAt;
  @override
  String? get ip;
  @override
  String? get country;
  @override
  String? get city;

  /// Create a copy of NewsViewModelModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewsViewModelModelImplCopyWith<_$NewsViewModelModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
