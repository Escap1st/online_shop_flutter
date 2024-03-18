import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../feature/cart/presentation/cart/cart_screen.dart';
import '../../feature/catalog/domain/entities/product.dart';
import '../../feature/catalog/presentation/catalog/catalog_screen.dart';
import '../../feature/catalog/presentation/product_details/product_details_screen.dart';

part 'routes.g.dart';

@TypedGoRoute<CatalogRoute>(
  path: '/',
  routes: [
    TypedGoRoute<ProductDetailsRoute>(
      path: 'product/:productId',
    ),
    TypedGoRoute<CartRoute>(
      path: 'cart',
    ),
  ],
)
class CatalogRoute extends GoRouteData {
  const CatalogRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CatalogScreen();
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

class CartRoute extends GoRouteData {
  const CartRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CartScreen();
  }
}
