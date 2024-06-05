import 'core/core_registrar.dart';
import 'core/di/registrar.dart';
import 'feature/authentication/registrar.dart';
import 'feature/cart/registrar.dart';
import 'feature/catalog/registrar.dart';
import 'feature/order/registrar.dart';
import 'feature/profile/registrar.dart';

class AppRegistrar implements IRegistrar {
  @override
  void register() {
    final registrars = [
      CoreRegistrar(),
      AuthenticationRegistrar(),
      CatalogRegistrar(),
      CartRegistrar(),
      OrderRegistrar(),
      ProfileRegistrar(),
    ];

    for (final e in registrars) {
      e.register();
    }
  }
}
