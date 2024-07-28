// ignore_for_file: overridden_fields

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../feature/authentication/presentation/screens/sign_in/sign_in_screen.dart';
import '../../feature/cart/presentation/cart/cart_screen.dart';
import '../../feature/catalog/domain/entities/product.dart';
import '../../feature/catalog/presentation/catalog/catalog_screen.dart';
import '../../feature/catalog/presentation/catalog_filter/catalog_filter_screen.dart';
import '../../feature/catalog/presentation/product_details/product_details_screen.dart';
import '../../feature/catalog/presentation/product_reviews/product_reviews_screen.dart';
import '../../feature/order/presentation/delivery_details/delivery_details_screen.dart';
import '../../feature/order/presentation/order_confirmation/order_confirmation_screen.dart';
import '../../feature/order/presentation/orders_history/orders_history_screen.dart';
import '../../feature/profile/presentation/profile/profile_screen.dart';
import '../../shared/presentation/screens/main_screen.dart';

part 'routes.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _catalogNavigatorKey = GlobalKey<NavigatorState>();
final _profileNavigatorKey = GlobalKey<NavigatorState>();

@TypedStatefulShellRoute<MainRoute>(
  branches: [
    TypedStatefulShellBranch<CatalogBranch>(
      routes: [
        TypedGoRoute<CatalogRoute>(
          path: '/catalog',
          routes: [
            TypedGoRoute<ProductDetailsRoute>(
              path: 'product/:productId',
              routes: [
                TypedGoRoute<ProductReviewsRoute>(
                  path: 'reviews',
                ),
              ],
            ),
            TypedGoRoute<CatalogFilterRoute>(
              path: 'catalog_filter',
            ),
            TypedGoRoute<CartRoute>(
              path: 'cart',
              routes: [
                TypedGoRoute<CartSignInRoute>(
                  path: 'sign_in',
                ),
                TypedGoRoute<DeliveryDetailsRoute>(
                  path: 'order_details',
                  routes: [
                    TypedGoRoute<OrderConfirmationRoute>(
                      path: 'order_confirmation',
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<ProfileBranch>(
      routes: [
        TypedGoRoute<ProfileRoute>(
          path: '/profile',
          routes: [
            TypedGoRoute<ProfileSignInRoute>(
              path: 'sign_in',
            ),
            TypedGoRoute<OrdersHistoryRoute>(
              path: 'orders_history',
            )
          ],
        ),
      ],
    ),
  ],
)
class MainRoute extends StatefulShellRouteData {
  const MainRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return MainScreen(navigationShell: navigationShell);
  }
}

class CatalogBranch extends StatefulShellBranchData {
  const CatalogBranch();

  static final $navigatorKey = _catalogNavigatorKey;
}

class ProfileBranch extends StatefulShellBranchData {
  const ProfileBranch();

  static final $navigatorKey = _profileNavigatorKey;
}

class CatalogRoute extends GoRouteData {
  const CatalogRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CatalogScreen();
  }
}

class ProfileRoute extends GoRouteData {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfileScreen();
  }
}

class ProductDetailsRoute extends GoRouteData {
  const ProductDetailsRoute({
    required this.productId,
    this.$extra,
  });

  final int productId;
  final Product? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductDetailsScreen(product: $extra, productId: productId);
  }
}

class ProductReviewsRoute extends GoRouteData {
  const ProductReviewsRoute({
    required this.productId,
    this.productName,
  });

  final int productId;
  final String? productName;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductReviewsScreen(
      productId: productId,
      productName: productName,
    );
  }
}

class CartRoute extends GoRouteData {
  const CartRoute();

  static final $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CartScreen();
  }
}

class CatalogFilterRoute extends GoRouteData {
  const CatalogFilterRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CatalogFilterScreen();
  }
}

class ProfileSignInRoute extends SignInRoute {
  const ProfileSignInRoute({this.redirectUri});

  @override
  final String? redirectUri;

  static final $parentNavigatorKey = rootNavigatorKey;
}

class CartSignInRoute extends SignInRoute {
  const CartSignInRoute({this.redirectUri});

  @override
  final String? redirectUri;

  static final $parentNavigatorKey = rootNavigatorKey;
}

class SignInRoute extends GoRouteData {
  const SignInRoute({this.redirectUri});

  final String? redirectUri;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SignInScreen(redirectUri: redirectUri);
  }
}

class OrderConfirmationRoute extends GoRouteData {
  const OrderConfirmationRoute();

  static final $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const OrderConfirmationScreen();
  }
}

class DeliveryDetailsRoute extends GoRouteData {
  const DeliveryDetailsRoute();

  static final $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DeliveryDetailsScreen();
  }
}

class OrdersHistoryRoute extends GoRouteData {
  const OrdersHistoryRoute();

  static final $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const OrdersHistoryScreen();
  }
}
