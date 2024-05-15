import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/typedefs.dart';
import 'order_details_model.dart';
import 'order_entry_model.dart';

part 'order_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderModel {
  const OrderModel({
    required this.entries,
    required this.details,
    required this.dateTime,
    required this.userId,
  });

  factory OrderModel.fromJson(Json json) => _$OrderModelFromJson(json);

  final List<OrderEntryModel> entries;
  final OrderDetailsModel details;
  final String dateTime;
  final String userId;

  Json toJson() => _$OrderModelToJson(this);
}
