import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/typedefs.dart';
import '../constants.dart';
import 'order_delivery_details_model.dart';
import 'order_entry_model.dart';

part 'order_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderModel {
  const OrderModel({
    required this.entries,
    required this.details,
    required this.dateTime,
    required this.userId,
    this.orderId,
  });

  factory OrderModel.fromJson(Json json) => _$OrderModelFromJson(json);

  final String? orderId;
  final List<OrderEntryModel> entries;
  final OrderDeliveryDetailsModel details;
  final String dateTime;
  @JsonKey(name: Constants.orderUserIdField)
  final String userId;

  Json toJson() => _$OrderModelToJson(this);
}
