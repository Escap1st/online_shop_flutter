import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../auth_state.dart';
import '../log.dart';
import 'routes.dart';

final routerProvider = Provider.autoDispose<GoRouter>(
  (ref) {
    final authState = ref.watch(authStateProvider);

    final router = GoRouter(
      observers: [
        TalkerRouteObserver(talker),
      ],
      routes: $appRoutes,
      redirect: (context, state) {
        final restrictedLocations = [
          const OrderDetailsRoute().location,
          const OrderConfirmationRoute().location,
        ];

        if (authState == AuthState.none && restrictedLocations.contains(state.uri.path)){
          return const SignInRoute().location;
        }

        return null;
      }
    );

    ref.onDispose(router.dispose);

    return router;
  },
);
