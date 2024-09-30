import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/typedefs.dart';

part 'set_product_review_request_model.g.dart';

@JsonSerializable()
class SetProductReviewRequestModel {
  SetProductReviewRequestModel({
    required this.title,
    required this.body,
  });

  factory SetProductReviewRequestModel.fromJson(Json json) =>
      _$SetProductReviewRequestModelFromJson(json);

  final String? title;
  final String? body;

  Json toJson() => _$SetProductReviewRequestModelToJson(this);
}
