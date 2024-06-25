import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/di/dependencies.dart';
import '../../../domain/entities/order.dart';
import '../../../domain/order_service.dart';

final orderConfirmationProvider = AsyncNotifierProvider.autoDispose
    .family<OrderConfirmationNotifier, bool, Order>(resolveDependency);

class OrderConfirmationNotifier extends AutoDisposeFamilyAsyncNotifier<bool, Order> {
  OrderConfirmationNotifier({
    required IOrderService orderService,
  })  : _orderService = orderService;

  final IOrderService _orderService;

  @override
  FutureOr<bool> build(Order arg) {
    return false;
  }

  Future<void> confirm() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _orderService.createOrder(
        arg.copyWith(
          dateTime: DateTime.now(),
        ),
      );
      return true;
    });
  }
}
