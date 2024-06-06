import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/auth_state.dart';
import '../../../../core/di/dependencies.dart';
import '../../domain/authentication_service.dart';

final logOutProvider = AutoDisposeAsyncNotifierProvider<LogOutNotifier, void>(resolveDependency);

class LogOutNotifier extends AutoDisposeAsyncNotifier<void> {
  LogOutNotifier({
    required IAuthenticationService authenticationService,
  }) : _authenticationService = authenticationService;

  final IAuthenticationService _authenticationService;

  @override
  Future<AuthState?> build() async {
    return null;
  }

  Future<void> call() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_authenticationService.logout);
    if (state.hasValue) {
      ref.read(authStateProvider.notifier).state = AuthState.none;
    }
  }
}
