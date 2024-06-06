import '../../../../core/auth_state.dart';
import '../entities/sign_in_email_params.dart';

abstract class IAuthenticationRepository {
  Future<bool> isAuthenticated();

  Future<AuthState> getAuthenticationState();

  Future<String?> getUserId();

  Future<String?> getLogin();

  Future<void> signInGoogle();

  Future<void> signInEmail({required SignInEmailParams params});

  Future<void> logout();
}
