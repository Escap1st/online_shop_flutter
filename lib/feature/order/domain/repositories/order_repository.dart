import '../entities/order.dart';

abstract interface class IOrderRepository {
  Future<void> createOrder(Order order);

  Future<void> cancelOrder(String orderId);

  Future<List<Order>> getOrders(String userId);
}
