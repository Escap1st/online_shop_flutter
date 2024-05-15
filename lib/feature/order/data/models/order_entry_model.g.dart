// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEntryModel _$OrderEntryModelFromJson(Map<String, dynamic> json) =>
    OrderEntryModel(
      productId: json['productId'] as int,
      price: (json['price'] as num).toDouble(),
      count: json['count'] as int,
    );

Map<String, dynamic> _$OrderEntryModelToJson(OrderEntryModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'price': instance.price,
      'count': instance.count,
    };
