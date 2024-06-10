import '../../../../shared/data/mappers/mapper.dart';
import '../../domain/entities/order_entry.dart';
import '../models/order_entry_model.dart';

class OrderEntryMapper implements EntityMapper<OrderEntry, OrderEntryModel> {
  const OrderEntryMapper();

  @override
  OrderEntryModel fromEntity(OrderEntry entity) {
    return OrderEntryModel(
      productId: entity.productId,
      price: entity.price,
      count: entity.count,
    );
  }

  @override
  OrderEntry toEntity(OrderEntryModel model) {
    return OrderEntry(
      productId: model.productId,
      price: model.price,
      count: model.count,
    );
  }
}
