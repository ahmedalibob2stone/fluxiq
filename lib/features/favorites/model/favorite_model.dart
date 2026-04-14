import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_model.freezed.dart';
part 'favorite_model.g.dart';


class TimestampConverter implements JsonConverter<DateTime, Object> {
  const TimestampConverter();

  @override
  DateTime fromJson(Object json) {
    if (json is Timestamp) {
      return json.toDate();
    } else if (json is String) {
      return DateTime.parse(json);
    }
    return DateTime.now();
  }

  @override
  Object toJson(DateTime object) => object.toIso8601String();
}

@freezed
class FavoriteModel with _$FavoriteModel {
  const factory FavoriteModel({
    required String newsId,
    required String title,
    required String imageUrl,
    required String category,
    required String userId,
    @TimestampConverter() required DateTime createdAt,
  }) = _FavoriteModel;

  factory FavoriteModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteModelFromJson(json);
}