import 'entities/order.dart';
import 'repositories/order_repository.dart';

abstract interface class IOrderService {
  Future<void> createOrder(Order order);

  Future<void> cancelOrder(String orderId);

  // TODO: consider about using id here
  Future<List<Order>> getOrders(String userId);
}

class OrderService implements IOrderService {
  OrderService({
    required IOrderRepository orderRepository,
  }) : _orderRepository = orderRepository;

  final IOrderRepository _orderRepository;

  @override
  Future<void> createOrder(Order order) => _orderRepository.createOrder(order);

  @override
  Future<void> cancelOrder(String orderId) => _orderRepository.cancelOrder(orderId);

  @override
  Future<List<Order>> getOrders(String userId) => _orderRepository.getOrders(userId);
}
