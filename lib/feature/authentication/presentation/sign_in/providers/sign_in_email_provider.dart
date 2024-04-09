import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/di/dependencies.dart';
import '../../../domain/authentication_service.dart';
import '../../../domain/entities/sign_in_email_params.dart';

final signInEmailProvider =
    StateNotifierProvider.autoDispose<SignInEmailNotifier, AsyncValue<bool>>(
  (ref) => resolveDependency(),
);

class SignInEmailNotifier extends StateNotifier<AsyncValue<bool>> {
  SignInEmailNotifier({
    required IAuthenticationService authenticationService,
  })  : _authenticationService = authenticationService,
        super(const AsyncData(false));

  final IAuthenticationService _authenticationService;

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncLoading();

    try {
      await _authenticationService.signInEmail(
            params: SignInEmailParams(
              email: email,
              password: password,
            ),
          );
      state = const AsyncData(true);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
