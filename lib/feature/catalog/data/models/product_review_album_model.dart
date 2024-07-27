import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/typedefs.dart';
import 'product_review_photo_model.dart';

part 'product_review_album_model.g.dart';

@JsonSerializable()
class ProductReviewAlbumModel {
  ProductReviewAlbumModel({required this.id, required this.photos});

  factory ProductReviewAlbumModel.fromJson(Json json) => _$ProductReviewAlbumModelFromJson(json);

  final String id;
  final ProductReviewPhotosPageModel photos;

  Json toJson() => _$ProductReviewAlbumModelToJson(this);
}
