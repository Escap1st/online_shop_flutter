import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/auth_state.dart';
import '../../../../core/di/dependencies.dart';
import '../../domain/authentication_service.dart';

final checkAuthenticationProvider =
    AutoDisposeAsyncNotifierProvider<CheckAuthenticationNotifier, AuthState?>(resolveDependency);

class CheckAuthenticationNotifier extends AutoDisposeAsyncNotifier<AuthState?> {
  CheckAuthenticationNotifier({
    required IAuthenticationService authenticationService,
  }) : _authenticationService = authenticationService;

  final IAuthenticationService _authenticationService;

  @override
  Future<AuthState?> build() async {
    return null;
  }

  Future<void> check() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_authenticationService.getAuthenticationState);
    if (state.hasValue) {
      ref.read(authStateProvider.notifier).state = state.requireValue!;
    }
  }
}
