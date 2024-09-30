// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_product_review_comment_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetProductReviewCommentRequestModel
    _$SetProductReviewCommentRequestModelFromJson(Map<String, dynamic> json) =>
        SetProductReviewCommentRequestModel(
          name: json['name'] as String?,
          body: json['body'] as String,
          email: json['email'] as String,
        );

Map<String, dynamic> _$SetProductReviewCommentRequestModelToJson(
        SetProductReviewCommentRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'body': instance.body,
      'email': instance.email,
    };
