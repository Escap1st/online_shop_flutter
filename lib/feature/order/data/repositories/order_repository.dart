import 'package:cloud_firestore/cloud_firestore.dart' as fs;

import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../constants.dart';
import '../mappers/order_mapper.dart';
import '../models/order_model.dart';

class OrderRepository implements IOrderRepository {
  OrderRepository({
    required fs.FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final fs.FirebaseFirestore _firestore;

  @override
  Future<void> createOrder(Order order) async {
    final orderModel = const OrderMapper().fromEntity(order);
    await _firestore.collection(Constants.ordersCollection).add(orderModel.toJson());
  }

  @override
  Future<void> cancelOrder(String orderId) async {
    await _firestore.collection(Constants.ordersCollection).doc(orderId).delete();
  }

  @override
  Future<List<Order>> getOrders(String userId) async {
    final ordersSnapshot = await _firestore
        .collection(Constants.ordersCollection)
        .where(Constants.orderUserIdField, isEqualTo: userId)
        .get();

    return ordersSnapshot.docs.map((e) {
      final orderModel = OrderModel.fromJson(e.data());
      return const OrderMapper().toEntity(orderModel).copyWith(orderId: e.id);
    }).toList();
  }
}
