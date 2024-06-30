import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/di/dependencies.dart';
import '../../../domain/order_service.dart';

final cancelOrderProvider =
    AsyncNotifierProvider.autoDispose.family<CancelOrderNotifier, bool, String>(
  resolveDependency,
);

class CancelOrderNotifier extends AutoDisposeFamilyAsyncNotifier<bool, String> {
  CancelOrderNotifier({
    required IOrderService orderService,
  }) : _orderService = orderService;

  final IOrderService _orderService;

  @override
  FutureOr<bool> build(String arg) {
    return false;
  }

  Future<void> cancel() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await _orderService.cancelOrder(arg);
      return true;
    });
  }
}
