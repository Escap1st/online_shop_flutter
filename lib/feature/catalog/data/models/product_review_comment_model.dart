import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/typedefs.dart';

part 'product_review_comment_model.g.dart';

@JsonSerializable()
class ProductReviewCommentModel {
  ProductReviewCommentModel({
    required this.id,
    required this.name,
    required this.body,
  });

  factory ProductReviewCommentModel.fromJson(Json json) =>
      _$ProductReviewCommentModelFromJson(json);

  final String id;
  final String name;
  final String body;

  Json toJson() => _$ProductReviewCommentModelToJson(this);
}

@JsonSerializable()
class ProductReviewCommentsPageModel {
  ProductReviewCommentsPageModel({required this.data});

  factory ProductReviewCommentsPageModel.fromJson(Json json) =>
      _$ProductReviewCommentsPageModelFromJson(json);

  final List<ProductReviewCommentModel> data;

  Json toJson() => _$ProductReviewCommentsPageModelToJson(this);
}
