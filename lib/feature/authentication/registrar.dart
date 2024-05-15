import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/di/dependencies.dart';
import '../../core/di/registrar.dart';
import 'data/repositories/authentication_repository.dart';
import 'domain/authentication_service.dart';
import 'domain/repositories/authentication_repository.dart';
import 'presentation/common_providers/check_authentication_provider.dart';
import 'presentation/screens/sign_in/providers/sign_in_email_provider.dart';
import 'presentation/screens/sign_in/providers/sign_in_google_provider.dart';

class AuthenticationRegistrar implements IRegistrar {
  @override
  void register() {
    registerLazySingletonDependency<IAuthenticationRepository>(
      () {
        final scopes = ['email'];
        final googleSignIn = GoogleSignIn(scopes: scopes);
        return AuthenticationRepository(
          firebaseAuth: FirebaseAuth.instance,
          googleSignIn: googleSignIn,
        );
      },
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
    registerFactoryDependency(
      () => CheckAuthenticationNotifier(
        authenticationService: resolveDependency(),
      ),
    );
  }
}
