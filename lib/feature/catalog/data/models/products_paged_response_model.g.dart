// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_paged_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsPagedResponseModel _$ProductsPagedResponseModelFromJson(
        Map<String, dynamic> json) =>
    ProductsPagedResponseModel(
      total: json['total'] as int,
      skip: json['skip'] as int,
      limit: json['limit'] as int,
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductsPagedResponseModelToJson(
        ProductsPagedResponseModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'skip': instance.skip,
      'limit': instance.limit,
      'products': instance.products,
    };
