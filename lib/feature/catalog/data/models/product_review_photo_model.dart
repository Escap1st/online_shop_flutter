import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/typedefs.dart';

part 'product_review_photo_model.g.dart';

@JsonSerializable()
class ProductReviewPhotoModel {
  ProductReviewPhotoModel({required this.url, required this.thumbnailUrl});

  factory ProductReviewPhotoModel.fromJson(Json json) => _$ProductReviewPhotoModelFromJson(json);

  final String url;
  final String thumbnailUrl;

  Json toJson() => _$ProductReviewPhotoModelToJson(this);
}

@JsonSerializable()
class ProductReviewPhotosPageModel {
  ProductReviewPhotosPageModel({required this.data});

  factory ProductReviewPhotosPageModel.fromJson(Json json) =>
      _$ProductReviewPhotosPageModelFromJson(json);

  final List<ProductReviewPhotoModel> data;

  Json toJson() => _$ProductReviewPhotosPageModelToJson(this);
}
