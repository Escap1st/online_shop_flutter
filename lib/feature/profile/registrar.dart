import '../../core/di/dependencies.dart';
import '../../core/di/registrar.dart';
import 'presentation/profile/providers/profile_overview_provider.dart';

class ProfileRegistrar implements IRegistrar {
  @override
  void register() {
    registerFactoryDependency(
      () => ProfileOverviewNotifier(
        authenticationService: resolveDependency(),
      ),
    );
  }
}
