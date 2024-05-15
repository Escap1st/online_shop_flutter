import 'entities/order.dart';
import 'repositories/order_repository.dart';

abstract interface class IOrderService {
  Future<void> createOrder(Order order);
}

class OrderService implements IOrderService {
  OrderService({
    required IOrderRepository orderRepository,
  }) : _orderRepository = orderRepository;

  final IOrderRepository _orderRepository;

  @override
  Future<void> createOrder(Order order) => _orderRepository.createOrder(order);
}
