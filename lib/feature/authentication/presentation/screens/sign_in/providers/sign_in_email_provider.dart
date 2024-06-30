import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/di/dependencies.dart';
import '../../../../domain/authentication_service.dart';
import '../../../../domain/entities/sign_in_email_params.dart';

final signInEmailProvider = AsyncNotifierProvider.autoDispose<SignInEmailNotifier, bool>(
  resolveDependency,
);

class SignInEmailNotifier extends AutoDisposeAsyncNotifier<bool> {
  SignInEmailNotifier({
    required IAuthenticationService authenticationService,
  }) : _authenticationService = authenticationService;

  final IAuthenticationService _authenticationService;

  @override
  FutureOr<bool> build() {
    return false;
  }

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await _authenticationService.signInEmail(
        params: SignInEmailParams(
          email: email,
          password: password,
        ),
      );
      return true;
    });
  }
}
