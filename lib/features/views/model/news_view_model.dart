import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_view_model.freezed.dart';
part 'news_view_model.g.dart';

@freezed
class NewsViewModelModel with _$NewsViewModelModel {
  const factory NewsViewModelModel({
    required DateTime viewedAt,
    String? ip,
    String? country,
    String? city,
  }) = _NewsViewModelModel;

  factory NewsViewModelModel.fromJson(Map<String, dynamic> json) =>
      _$NewsViewModelModelFromJson(json);
}