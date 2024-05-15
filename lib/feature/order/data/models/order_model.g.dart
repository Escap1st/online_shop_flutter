// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      entries: (json['entries'] as List<dynamic>)
          .map((e) => OrderEntryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      details:
          OrderDetailsModel.fromJson(json['details'] as Map<String, dynamic>),
      dateTime: json['dateTime'] as String,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'entries': instance.entries.map((e) => e.toJson()).toList(),
      'details': instance.details.toJson(),
      'dateTime': instance.dateTime,
      'userId': instance.userId,
    };
