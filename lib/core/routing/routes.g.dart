// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $mainRoute,
    ];

RouteBase get $mainRoute => StatefulShellRouteData.$route(
      parentNavigatorKey: MainRoute.$parentNavigatorKey,
      factory: $MainRouteExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          navigatorKey: CatalogBranch.$navigatorKey,
          routes: [
            GoRouteData.$route(
              path: '/catalog',
              factory: $CatalogRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'product/:productId',
                  factory: $ProductDetailsRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'catalog_filter',
                  factory: $CatalogFilterRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'cart',
                  parentNavigatorKey: CartRoute.$parentNavigatorKey,
                  factory: $CartRouteExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'sign_in',
                      parentNavigatorKey: CartSignInRoute.$parentNavigatorKey,
                      factory: $CartSignInRouteExtension._fromState,
                    ),
                    GoRouteData.$route(
                      path: 'order_details',
                      parentNavigatorKey:
                          DeliveryDetailsRoute.$parentNavigatorKey,
                      factory: $DeliveryDetailsRouteExtension._fromState,
                      routes: [
                        GoRouteData.$route(
                          path: 'order_confirmation',
                          parentNavigatorKey:
                              OrderConfirmationRoute.$parentNavigatorKey,
                          factory: $OrderConfirmationRouteExtension._fromState,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          navigatorKey: ProfileBranch.$navigatorKey,
          routes: [
            GoRouteData.$route(
              path: '/profile',
              factory: $ProfileRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'sign_in',
                  parentNavigatorKey: ProfileSignInRoute.$parentNavigatorKey,
                  factory: $ProfileSignInRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'orders_history',
                  parentNavigatorKey: OrdersHistoryRoute.$parentNavigatorKey,
                  factory: $OrdersHistoryRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
      ],
    );

extension $MainRouteExtension on MainRoute {
  static MainRoute _fromState(GoRouterState state) => const MainRoute();
}

extension $CatalogRouteExtension on CatalogRoute {
  static CatalogRoute _fromState(GoRouterState state) => const CatalogRoute();

  String get location => GoRouteData.$location(
        '/catalog',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ProductDetailsRouteExtension on ProductDetailsRoute {
  static ProductDetailsRoute _fromState(GoRouterState state) =>
      ProductDetailsRoute(
        productId: int.parse(state.pathParameters['productId']!),
        $extra: state.extra as Product?,
      );

  String get location => GoRouteData.$location(
        '/catalog/product/${Uri.encodeComponent(productId.toString())}',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $CatalogFilterRouteExtension on CatalogFilterRoute {
  static CatalogFilterRoute _fromState(GoRouterState state) =>
      const CatalogFilterRoute();

  String get location => GoRouteData.$location(
        '/catalog/catalog_filter',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CartRouteExtension on CartRoute {
  static CartRoute _fromState(GoRouterState state) => const CartRoute();

  String get location => GoRouteData.$location(
        '/catalog/cart',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CartSignInRouteExtension on CartSignInRoute {
  static CartSignInRoute _fromState(GoRouterState state) => CartSignInRoute(
        redirectUri: state.uri.queryParameters['redirect-uri'],
      );

  String get location => GoRouteData.$location(
        '/catalog/cart/sign_in',
        queryParams: {
          if (redirectUri != null) 'redirect-uri': redirectUri,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DeliveryDetailsRouteExtension on DeliveryDetailsRoute {
  static DeliveryDetailsRoute _fromState(GoRouterState state) =>
      const DeliveryDetailsRoute();

  String get location => GoRouteData.$location(
        '/catalog/cart/order_details',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $OrderConfirmationRouteExtension on OrderConfirmationRoute {
  static OrderConfirmationRoute _fromState(GoRouterState state) =>
      const OrderConfirmationRoute();

  String get location => GoRouteData.$location(
        '/catalog/cart/order_details/order_confirmation',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ProfileRouteExtension on ProfileRoute {
  static ProfileRoute _fromState(GoRouterState state) => const ProfileRoute();

  String get location => GoRouteData.$location(
        '/profile',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ProfileSignInRouteExtension on ProfileSignInRoute {
  static ProfileSignInRoute _fromState(GoRouterState state) =>
      ProfileSignInRoute(
        redirectUri: state.uri.queryParameters['redirect-uri'],
      );

  String get location => GoRouteData.$location(
        '/profile/sign_in',
        queryParams: {
          if (redirectUri != null) 'redirect-uri': redirectUri,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $OrdersHistoryRouteExtension on OrdersHistoryRoute {
  static OrdersHistoryRoute _fromState(GoRouterState state) =>
      OrdersHistoryRoute(
        $extra: state.extra as List<Order>?,
      );

  String get location => GoRouteData.$location(
        '/profile/orders_history',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}
