import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'like_model.freezed.dart';
part 'like_model.g.dart';

@freezed
class LikeModel with _$LikeModel {
  const factory LikeModel({
    required String newsId,
    required String newsTitle,
    required String newsDescription,
    required String newsImageUrl,
    required String newsUserId,
    required DateTime likedAt,
    required String category,
     required String email,
    required String name,
  }) = _LikeModel;

  factory LikeModel.fromJson(Map<String, dynamic> json) =>
      _$LikeModelFromJson(json);

  factory LikeModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return LikeModel(
      newsId: doc.id,
      newsTitle: data['newsTitle'] ?? '',
      newsDescription: data['newsDescription'] ?? '',
      newsImageUrl: data['newsImageUrl'] ?? '',
      newsUserId: data['newsUserId'] ?? '',
      likedAt: (data['likedAt'] as Timestamp).toDate(), category: data['category'] ?? '',
        email: data['email'] ?? '', name:  data['name'] ?? '',

    );
  }
}