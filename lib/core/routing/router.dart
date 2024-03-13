import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../log.dart';
import 'routes.dart';

final router = GoRouter(
  observers: [
    TalkerRouteObserver(talker),
  ],
  routes: $appRoutes,
);
