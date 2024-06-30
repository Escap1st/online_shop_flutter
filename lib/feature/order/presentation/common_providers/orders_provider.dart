import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/di/dependencies.dart';
import '../../domain/entities/order.dart';
import '../../domain/order_service.dart';

final ordersProvider = AutoDisposeAsyncNotifierProvider<OrdersNotifier, List<Order>>(
  resolveDependency,
);

class OrdersNotifier extends AutoDisposeAsyncNotifier<List<Order>> {
  OrdersNotifier({
    required IOrderService orderService,
  }) : _orderService = orderService;

  final IOrderService _orderService;

  @override
  FutureOr<List<Order>> build() {
    return _orderService.getOrders();
  }

  Future<void> onOrderCanceled(String id) async {
    if (!state.hasValue) {
      return;
    }

    state = AsyncData(
      state.requireValue.where((e) => e.orderId != id).toList(),
    );
  }
}
