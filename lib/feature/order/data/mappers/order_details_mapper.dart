import '../../../../shared/data/mappers/mapper.dart';
import '../../domain/entities/order_details.dart';
import '../models/order_details_model.dart';

class OrderDetailsMapper implements EntityMapper<OrderDetails, OrderDetailsModel> {
  const OrderDetailsMapper();

  @override
  OrderDetailsModel fromEntity(OrderDetails entity) {
    return OrderDetailsModel(
      name: entity.name,
      surname: entity.surname,
      address: entity.address,
    );
  }

  @override
  OrderDetails toEntity(OrderDetailsModel model) {
    throw UnimplementedError();
  }
}
