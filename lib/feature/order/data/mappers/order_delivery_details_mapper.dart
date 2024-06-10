import '../../../../shared/data/mappers/mapper.dart';
import '../../domain/entities/order_delivery_details.dart';
import '../models/order_delivery_details_model.dart';

class OrderDeliveryDetailsMapper
    implements EntityMapper<OrderDeliveryDetails, OrderDeliveryDetailsModel> {
  const OrderDeliveryDetailsMapper();

  @override
  OrderDeliveryDetailsModel fromEntity(OrderDeliveryDetails entity) {
    return OrderDeliveryDetailsModel(
      name: entity.name,
      surname: entity.surname,
      address: entity.address,
    );
  }

  @override
  OrderDeliveryDetails toEntity(OrderDeliveryDetailsModel model) {
    return OrderDeliveryDetails(
      name: model.name,
      surname: model.surname,
      address: model.address,
    );
  }
}
