import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/di/dependencies.dart';
import '../../core/di/registrar.dart';
import 'data/repositories/order_repository.dart';
import 'domain/order_service.dart';
import 'domain/repositories/order_repository.dart';
import 'presentation/common_providers/orders_provider.dart';
import 'presentation/order_confirmation/providers/order_confirmation_provider.dart';
import 'presentation/orders_history/providers/cancel_order_provider.dart';

class OrderRegistrar implements IRegistrar {
  @override
  void register() {
    registerLazySingletonDependency<IOrderRepository>(
      () => OrderRepository(
        firestore: FirebaseFirestore.instance,
      ),
    );
    registerLazySingletonDependency<IOrderService>(
      () => OrderService(
        authenticationService: resolveDependency(),
        orderRepository: resolveDependency(),
      ),
    );
    registerFactoryDependency(
      () => OrderConfirmationNotifier(
        orderService: resolveDependency(),
      ),
    );
    registerFactoryDependency(
      () => CancelOrderNotifier(
        orderService: resolveDependency(),
      ),
    );
    registerFactoryDependency(
      () => OrdersNotifier(
        orderService: resolveDependency(),
      ),
    );
  }
}
