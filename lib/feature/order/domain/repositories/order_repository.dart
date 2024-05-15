import '../entities/order.dart';

abstract interface class IOrderRepository {
  Future<void> createOrder(Order order);
}
