import '../../authentication/domain/authentication_service.dart';
import '../../authentication/domain/entities/exceptions.dart';
import 'entities/order.dart';
import 'repositories/order_repository.dart';

abstract interface class IOrderService {
  Future<void> createOrder(Order order);

  Future<void> cancelOrder(String orderId);

  Future<List<Order>> getOrders();
}

class OrderService implements IOrderService {
  OrderService({
    required IAuthenticationService authenticationService,
    required IOrderRepository orderRepository,
  })  : _authenticationService = authenticationService,
        _orderRepository = orderRepository;

  final IAuthenticationService _authenticationService;
  final IOrderRepository _orderRepository;

  @override
  Future<void> createOrder(Order order) => _orderRepository.createOrder(order);

  @override
  Future<void> cancelOrder(String orderId) async {
    final userId = await _authenticationService.getUserId();
    if (userId == null) {
      throw UnauthenticatedUserException();
    }
    return _orderRepository.cancelOrder(orderId);
  }

  @override
  Future<List<Order>> getOrders() async {
    final userId = await _authenticationService.getUserId();
    if (userId == null) {
      throw UnauthenticatedUserException();
    }
    return _orderRepository.getOrders(userId);
  }
}
