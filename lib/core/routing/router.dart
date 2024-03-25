import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

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
      redirect: (context, state) {
        final restrictedLocations = [
          const OrderDetailsRoute().location,
          const OrderConfirmationRoute().location,
        ];

        if (authState.value == AuthState.none && restrictedLocations.contains(state.uri.path)) {
          return const SignInRoute().location;
        }

        return null;
      },
    );

    ref.onDispose(router.dispose);

    return router;
  },
);
