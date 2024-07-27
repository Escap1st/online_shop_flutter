import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/typedefs.dart';
import 'product_review_comment_model.dart';
import 'product_reviewer_model.dart';

part 'product_review_model.g.dart';

@JsonSerializable()
class ProductReviewModel {
  ProductReviewModel({
    required this.id,
    required this.title,
    required this.body,
    required this.user,
    required this.comments,
  });

  factory ProductReviewModel.fromJson(Json json) => _$ProductReviewModelFromJson(json);

  final String id;
  final String title;
  final String body;
  final ProductReviewerModel user;
  final ProductReviewCommentsPageModel comments;

  Json toJson() => _$ProductReviewModelToJson(this);
}
