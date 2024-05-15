import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/di/dependencies.dart';
import '../../../../authentication/domain/authentication_service.dart';
import '../../../../authentication/domain/entities/exceptions.dart';
import '../../../domain/entities/order.dart';
import '../../../domain/order_service.dart';

final orderConfirmationProvider = AsyncNotifierProvider.autoDispose
    .family<OrderConfirmationNotifier, bool, Order>(resolveDependency);

class OrderConfirmationNotifier extends AutoDisposeFamilyAsyncNotifier<bool, Order> {
  OrderConfirmationNotifier({
    required IOrderService orderService,
    required IAuthenticationService authenticationService,
  })  : _orderService = orderService,
        _authenticationService = authenticationService;

  final IOrderService _orderService;
  final IAuthenticationService _authenticationService;

  @override
  FutureOr<bool> build(Order arg) {
    return false;
  }

  Future<void> confirm() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final userId = await _authenticationService.getUserId();
      if (userId == null) {
        throw UnauthenticatedUserException();
      }

      await _orderService.createOrder(
        arg.copyWith(
          dateTime: DateTime.now(),
          userId: userId,
        ),
      );
      return true;
    });
  }
}
