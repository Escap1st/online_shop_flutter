import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../feature/authentication/presentation/common_providers/check_authentication_provider.dart';
import '../auth_state.dart';
import '../log.dart';
import 'routes.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    final routerKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');
    final authState = ValueNotifier<AuthState>(AuthState.none);
    ref
      ..onDispose(authState.dispose)
      ..listen(
        authStateProvider,
        (_, next) {
          authState.value = next;
        },
      );

    final router = GoRouter(
      navigatorKey: routerKey,
      refreshListenable: authState,
      observers: [
        TalkerRouteObserver(talker),
      ],
      routes: $appRoutes,
      initialLocation: '/catalog',
      redirect: (context, state) async {
        final restrictedLocations = [
          const DeliveryDetailsRoute().location,
          const OrderConfirmationRoute().location,
        ];

        if (restrictedLocations.contains(state.uri.path) && authState.value == AuthState.none) {
          await ref.read(checkAuthenticationProvider.notifier).check();
          final checkAuthenticationState = ref.read(checkAuthenticationProvider);

          if (checkAuthenticationState is AsyncData) {
            ref.read(authStateProvider.notifier).state = checkAuthenticationState.value!;
            if (checkAuthenticationState.value == AuthState.none) {
              return const SignInRoute().location;
            }
          } else {
            return const SignInRoute().location;
          }
        }

        return null;
      },
    );

    ref.onDispose(router.dispose);

    return router;
  },
);
