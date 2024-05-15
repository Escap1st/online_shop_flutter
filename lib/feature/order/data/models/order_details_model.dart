import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/typedefs.dart';

part 'order_details_model.g.dart';

@JsonSerializable()
class OrderDetailsModel {
  const OrderDetailsModel({required this.name, required this.surname, required this.address});

  factory OrderDetailsModel.fromJson(Json json) => _$OrderDetailsModelFromJson(json);

  final String name;
  final String surname;
  final String address;

  Json toJson() => _$OrderDetailsModelToJson(this);
}
