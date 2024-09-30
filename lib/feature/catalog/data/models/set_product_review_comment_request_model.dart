import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/typedefs.dart';

part 'set_product_review_comment_request_model.g.dart';

@JsonSerializable()
class SetProductReviewCommentRequestModel {
  SetProductReviewCommentRequestModel({
    required this.name,
    required this.body,
    required this.email,
  });

  factory SetProductReviewCommentRequestModel.fromJson(Json json) =>
      _$SetProductReviewCommentRequestModelFromJson(json);

  final String? name;
  final String body;
  final String email;

  Json toJson() => _$SetProductReviewCommentRequestModelToJson(this);
}
