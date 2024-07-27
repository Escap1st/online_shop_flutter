import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/typedefs.dart';

part 'product_reviewer_model.g.dart';

@JsonSerializable()
class ProductReviewerModel {
  ProductReviewerModel({required this.id, required this.username});

  factory ProductReviewerModel.fromJson(Json json) => _$ProductReviewerModelFromJson(json);

  final String id;
  final String username;

  Json toJson() => _$ProductReviewerModelToJson(this);
}
