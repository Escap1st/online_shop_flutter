import '../entities/sign_in_email_params.dart';

abstract class IAuthenticationRepository {
  Future<void> signInGoogle();

  Future<void> signInEmail({required SignInEmailParams params});
}
