import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/di/dependencies.dart';
import '../../../../domain/authentication_service.dart';

final signInGoogleProvider = AsyncNotifierProvider.autoDispose<SignInGoogleNotifier, bool>(
  resolveDependency,
);

class SignInGoogleNotifier extends AutoDisposeAsyncNotifier<bool> {
  SignInGoogleNotifier({
    required IAuthenticationService authenticationService,
  }) : _authenticationService = authenticationService;

  final IAuthenticationService _authenticationService;

  @override
  FutureOr<bool> build() {
    return false;
  }

  Future<void> signIn() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await _authenticationService.signInGoogle();
      return true;
    });
  }
}
