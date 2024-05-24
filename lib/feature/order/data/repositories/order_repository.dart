import 'package:cloud_firestore/cloud_firestore.dart' as fs;

import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../constants.dart';
import '../mappers/order_mapper.dart';

class OrderRepository implements IOrderRepository {
  OrderRepository({
    required fs.FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final fs.FirebaseFirestore _firestore;

  @override
  Future<void> createOrder(Order order) async {
    final model = const OrderMapper().fromEntity(order);
    await _firestore.collection(Constants.ordersCollection).add(model.toJson());
  }

  Future<void> cancelOrder() async {}

  Future<List<Order>> getOrders() async {
    return [];
  }
}
