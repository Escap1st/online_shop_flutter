import '../../../core/auth_state.dart';
import 'entities/sign_in_email_params.dart';
import 'repositories/authentication_repository.dart';

abstract class IAuthenticationService {
  Future<bool> isAuthenticated();

  Future<AuthState> getAuthenticationState();

  Future<String?> getUserId();

  Future<void> signInGoogle();

  Future<void> signInEmail({required SignInEmailParams params});
}

class AuthenticationService implements IAuthenticationService {
  AuthenticationService({
    required IAuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;

  final IAuthenticationRepository _authenticationRepository;

  @override
  Future<bool> isAuthenticated() => _authenticationRepository.isAuthenticated();

  @override
  Future<AuthState> getAuthenticationState() => _authenticationRepository.getAuthenticationState();

  @override
  Future<String?> getUserId() => _authenticationRepository.getUserId();

  @override
  Future<void> signInEmail({required SignInEmailParams params}) =>
      _authenticationRepository.signInEmail(params: params);

  @override
  Future<void> signInGoogle() => _authenticationRepository.signInGoogle();
}
