import '../../core/di/dependencies.dart';
import '../../core/di/registrar.dart';
import 'data/repositories/cart_repository.dart';
import 'domain/cart_service.dart';
import 'domain/repositories/cart_repository.dart';
import 'presentation/cart/providers/cart/cart_provider.dart';

class CartRegistrar implements IRegistrar {
  @override
  void register() {
    registerLazySingletonDependency<ICartRepository>(CartRepository.new);
    registerLazySingletonDependency<ICartService>(
      () => CartService(cartRepository: resolveDependency()),
    );
    registerFactoryDependency(
      () => CartNotifier(cartService: resolveDependency()),
    );
  }
}
