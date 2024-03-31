import 'entities/sign_in_email_params.dart';
import 'repositories/authentication_repository.dart';

abstract class IAuthenticationService {
  Future<void> signInGoogle();

  Future<void> signInEmail({required SignInEmailParams params});
}

class AuthenticationService implements IAuthenticationService {
  AuthenticationService({
    required IAuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;

  final IAuthenticationRepository _authenticationRepository;

  @override
  Future<void> signInEmail({required SignInEmailParams params}) =>
      _authenticationRepository.signInEmail(params: params);

  @override
  Future<void> signInGoogle() => _authenticationRepository.signInGoogle();
}
