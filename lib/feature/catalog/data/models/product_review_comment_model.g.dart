// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_review_comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductReviewCommentModel _$ProductReviewCommentModelFromJson(
        Map<String, dynamic> json) =>
    ProductReviewCommentModel(
      id: json['id'] as String,
      name: json['name'] as String,
      body: json['body'] as String,
    );

Map<String, dynamic> _$ProductReviewCommentModelToJson(
        ProductReviewCommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'body': instance.body,
    };

ProductReviewCommentsPageModel _$ProductReviewCommentsPageModelFromJson(
        Map<String, dynamic> json) =>
    ProductReviewCommentsPageModel(
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              ProductReviewCommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductReviewCommentsPageModelToJson(
        ProductReviewCommentsPageModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
