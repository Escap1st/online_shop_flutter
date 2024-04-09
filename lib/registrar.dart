import 'core/core_registrar.dart';
import 'core/di/registrar.dart';
import 'feature/authentication/registrar.dart';
import 'feature/cart/registrar.dart';
import 'feature/catalog/registrar.dart';

class AppRegistrar implements IRegistrar {
  @override
  void register() {
    final registrars = [
      CoreRegistrar(),
      AuthenticationRegistrar(),
      CatalogRegistrar(),
      CartRegistrar(),
    ];

    for (final e in registrars) {
      e.register();
    }
  }
}
