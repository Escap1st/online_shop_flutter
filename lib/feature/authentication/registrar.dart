import '../../core/di/dependencies.dart';
import '../../core/di/registrar.dart';
import 'data/repositories/authentication_repository.dart';
import 'domain/authentication_service.dart';
import 'domain/repositories/authentication_repository.dart';
import 'presentation/sign_in/providers/sign_in_email_provider.dart';
import 'presentation/sign_in/providers/sign_in_google_provider.dart';

class AuthenticationRegistrar implements IRegistrar {
  @override
  void register() {
    registerLazySingletonDependency<IAuthenticationRepository>(
      () => AuthenticationRepository(),
    );
    registerLazySingletonDependency<IAuthenticationService>(
      () => AuthenticationService(
        authenticationRepository: resolveDependency(),
      ),
    );
    registerFactoryDependency(
      () => SignInEmailNotifier(
        authenticationService: resolveDependency(),
      ),
    );
    registerFactoryDependency(
      () => SignInGoogleNotifier(
        authenticationService: resolveDependency(),
      ),
    );
  }
}
