// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_review_album_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductReviewAlbumModel _$ProductReviewAlbumModelFromJson(
        Map<String, dynamic> json) =>
    ProductReviewAlbumModel(
      id: json['id'] as String,
      photos: ProductReviewPhotosPageModel.fromJson(
          json['photos'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductReviewAlbumModelToJson(
        ProductReviewAlbumModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'photos': instance.photos,
    };
