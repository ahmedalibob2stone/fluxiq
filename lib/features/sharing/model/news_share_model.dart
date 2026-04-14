import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'news_share_model.freezed.dart';
part 'news_share_model.g.dart';


@freezed
class NewsShareModel with _$NewsShareModel {
  const factory NewsShareModel({
    required String shareId,
    required DateTime sharedAt,
    required String platform,

  }) = _NewsShareModel;

  factory NewsShareModel.fromJson(Map<String, dynamic> json)
  => _$NewsShareModelFromJson(json);

  factory NewsShareModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NewsShareModel(
      shareId: doc.id,
      sharedAt: (data['sharedAt'] as Timestamp).toDate(),
      platform: data['platform'],
    );
  }
}