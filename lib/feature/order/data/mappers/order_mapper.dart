import '../../../../shared/data/mappers/mapper.dart';
import '../../domain/entities/order.dart';
import '../models/order_model.dart';
import 'order_details_mapper.dart';
import 'order_entry_mapper.dart';

class OrderMapper implements EntityMapper<Order, OrderModel> {
  const OrderMapper();

  @override
  OrderModel fromEntity(Order entity) {
    return OrderModel(
      entries: entity.entries.map(const OrderEntryMapper().fromEntity).toList(),
      details: const OrderDetailsMapper().fromEntity(entity.details),
      dateTime: entity.dateTime!.toIso8601String(),
      userId: entity.userId!,
    );
  }

  @override
  Order toEntity(OrderModel model) {
    throw UnimplementedError();
  }
}
