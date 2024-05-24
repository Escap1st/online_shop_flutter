// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_delivery_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDeliveryDetailsModel _$OrderDeliveryDetailsModelFromJson(
        Map<String, dynamic> json) =>
    OrderDeliveryDetailsModel(
      name: json['name'] as String,
      surname: json['surname'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$OrderDeliveryDetailsModelToJson(
        OrderDeliveryDetailsModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'address': instance.address,
    };
