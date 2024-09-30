// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductReviewModel _$ProductReviewModelFromJson(Map<String, dynamic> json) =>
    ProductReviewModel(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      user: json['user'] == null
          ? null
          : ProductReviewerModel.fromJson(json['user'] as Map<String, dynamic>),
      comments: json['comments'] == null
          ? null
          : ProductReviewCommentsPageModel.fromJson(
              json['comments'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductReviewModelToJson(ProductReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'user': instance.user,
      'comments': instance.comments,
    };
