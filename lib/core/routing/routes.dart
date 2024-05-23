import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../feature/authentication/presentation/screens/sign_in/sign_in_screen.dart';
import '../../feature/cart/presentation/cart/cart_screen.dart';
import '../../feature/catalog/domain/entities/product.dart';
import '../../feature/catalog/presentation/catalog/catalog_screen.dart';
import '../../feature/catalog/presentation/catalog_filter/catalog_filter_screen.dart';
import '../../feature/catalog/presentation/product_details/product_details_screen.dart';
import '../../feature/order/presentation/order_confirmation/order_confirmation_screen.dart';
import '../../feature/order/presentation/order_details/order_details_screen.dart';
import '../../feature/profile/presentation/profile/profile_screen.dart';
import '../../shared/presentation/screens/main_screen.dart';

part 'routes.g.dart';

@TypedStatefulShellRoute<MainRoute>(
  branches: [
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<CatalogRoute>(
          path: '/catalog',
          routes: [
            TypedGoRoute<ProductDetailsRoute>(
              path: 'product/:productId',
            ),
            TypedGoRoute<CatalogFilterRoute>(
              path: 'catalog_filter',
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<ProfileRoute>(
          path: '/profile',
        ),
      ],
    ),
  ],
)
class MainRoute extends StatefulShellRouteData {
  const MainRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return MainScreen(navigationShell: navigationShell);
  }
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

@TypedGoRoute<CartRoute>(
  path: '/cart',
  routes: [
    TypedGoRoute<SignInRoute>(
      path: 'sign_in',
    ),
    TypedGoRoute<OrderDetailsRoute>(
      path: 'order_details',
      routes: [
        TypedGoRoute<OrderConfirmationRoute>(
          path: 'order_confirmation',
        ),
      ],
    ),
  ],
)
class CartRoute extends GoRouteData {
  const CartRoute();

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

class SignInRoute extends GoRouteData {
  const SignInRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignInScreen();
  }
}

class OrderConfirmationRoute extends GoRouteData {
  const OrderConfirmationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const OrderConfirmationScreen();
  }
}

class OrderDetailsRoute extends GoRouteData {
  const OrderDetailsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const OrderDetailsScreen();
  }
}
