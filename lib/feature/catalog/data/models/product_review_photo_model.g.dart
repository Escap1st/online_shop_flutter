// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_review_photo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductReviewPhotoModel _$ProductReviewPhotoModelFromJson(
        Map<String, dynamic> json) =>
    ProductReviewPhotoModel(
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );

Map<String, dynamic> _$ProductReviewPhotoModelToJson(
        ProductReviewPhotoModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'thumbnailUrl': instance.thumbnailUrl,
    };

ProductReviewPhotosPageModel _$ProductReviewPhotosPageModelFromJson(
        Map<String, dynamic> json) =>
    ProductReviewPhotosPageModel(
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              ProductReviewPhotoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductReviewPhotosPageModelToJson(
        ProductReviewPhotosPageModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
