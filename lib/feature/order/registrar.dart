import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/di/dependencies.dart';
import '../../core/di/registrar.dart';
import 'data/repositories/order_repository.dart';
import 'domain/order_service.dart';
import 'domain/repositories/order_repository.dart';
import 'presentation/order_confirmation/providers/order_confirmation_provider.dart';

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
        orderRepository: resolveDependency(),
      ),
    );
    registerFactoryDependency(
      () => OrderConfirmationNotifier(
        orderService: resolveDependency(),
        authenticationService: resolveDependency(),
      ),
    );
  }
}
