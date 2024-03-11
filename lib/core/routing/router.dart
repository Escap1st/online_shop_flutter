import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../feature/catalog/presentation/catalog/catalog_screen.dart';
import '../log.dart';

final router = GoRouter(
  observers: [
    TalkerRouteObserver(talker),
  ],
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CatalogScreen(),
    ),
  ],
);
