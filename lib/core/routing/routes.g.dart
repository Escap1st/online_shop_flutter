// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $mainRoute,
      $cartRoute,
    ];

RouteBase get $mainRoute => StatefulShellRouteData.$route(
      factory: $MainRouteExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
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
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/profile',
              factory: $ProfileRouteExtension._fromState,
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

RouteBase get $cartRoute => GoRouteData.$route(
      path: '/cart',
      factory: $CartRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'sign_in',
          factory: $SignInRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'order_details',
          factory: $DeliveryDetailsRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'order_confirmation',
              factory: $OrderConfirmationRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $CartRouteExtension on CartRoute {
  static CartRoute _fromState(GoRouterState state) => const CartRoute();

  String get location => GoRouteData.$location(
        '/cart',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SignInRouteExtension on SignInRoute {
  static SignInRoute _fromState(GoRouterState state) => const SignInRoute();

  String get location => GoRouteData.$location(
        '/cart/sign_in',
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
        '/cart/order_details',
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
        '/cart/order_details/order_confirmation',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
