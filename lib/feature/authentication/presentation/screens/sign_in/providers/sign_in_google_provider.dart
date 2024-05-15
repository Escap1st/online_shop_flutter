import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/di/dependencies.dart';
import '../../../../domain/authentication_service.dart';

final signInGoogleProvider =
    StateNotifierProvider.autoDispose<SignInGoogleNotifier, AsyncValue<bool>>(
  (ref) => resolveDependency(),
);

class SignInGoogleNotifier extends StateNotifier<AsyncValue<bool>> {
  SignInGoogleNotifier({
    required IAuthenticationService authenticationService,
  })  : _authenticationService = authenticationService,
        super(const AsyncData(false));

  final IAuthenticationService _authenticationService;

  Future<void> signIn() async {
    state = const AsyncLoading();

    try {
      await _authenticationService.signInGoogle();
      state = const AsyncData(true);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
