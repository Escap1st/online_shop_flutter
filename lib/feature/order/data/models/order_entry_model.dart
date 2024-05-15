import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/typedefs.dart';

part 'order_entry_model.g.dart';

@JsonSerializable()
class OrderEntryModel {
  const OrderEntryModel({required this.productId, required this.price, required this.count});

  factory OrderEntryModel.fromJson(Json json) => _$OrderEntryModelFromJson(json);

  final int productId;
  final double price;
  final int count;

  Json toJson() => _$OrderEntryModelToJson(this);
}
