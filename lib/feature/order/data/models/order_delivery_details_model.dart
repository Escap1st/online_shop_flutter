import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/typedefs.dart';

part 'order_delivery_details_model.g.dart';

@JsonSerializable()
class OrderDeliveryDetailsModel {
  const OrderDeliveryDetailsModel({
    required this.name,
    required this.surname,
    required this.address,
  });

  factory OrderDeliveryDetailsModel.fromJson(Json json) =>
      _$OrderDeliveryDetailsModelFromJson(json);

  final String name;
  final String surname;
  final String address;

  Json toJson() => _$OrderDeliveryDetailsModelToJson(this);
}
