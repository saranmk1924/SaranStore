import 'package:saranstore/feature/home/domain/entity/review_entity.dart';

class ReviewModel extends ReviewEntity {
  ReviewModel({
    required super.comment,
    required super.date,
    required super.rating,
    required super.reviewerName,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      comment: json['comment']??'',
      date: json['date']??'',
      rating: json['rating']??1,
      reviewerName: json['reviewerName']??'',
    );
  }
}
