import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/di/dependencies.dart';
import '../../../../../catalog/domain/entities/product.dart';
import '../../../../domain/cart_service.dart';
import '../../../../domain/entities/cart.dart';

part 'cart_state.dart';

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return resolveDependency();
});

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier({required ICartService cartService})
      : _cartService = cartService,
        super(
          const CartLoaded(
            cart: Cart(positions: {}),
          ),
        ) {
    load();
  }

  final ICartService _cartService;

  Future<void> load() async {
    try {
      state = CartLoaded(cart: await _cartService.getCart());
    } catch (e, st){
      state = CartFailed(
        cart: state.cart,
        exception: e,
        stackTrace: st,
      );
    }
  }

  Future<void> addItem({required Product product}) async {
    try {
      await _cartService.addItem(product: product);
      state = CartLoaded(
        cart: Cart(
          positions: Map.of(state.cart.positions)
            ..update(
              product,
              (value) => value + 1,
              ifAbsent: () => 1,
            ),
        ),
      );
    } catch (e, st) {
      state = CartFailed(
        cart: state.cart,
        exception: e,
        stackTrace: st,
      );
    }
  }

  Future<void> removeItem({required Product product}) async {
    try {
      await _cartService.removeItem(product: product);
      final newMap = Map.of(state.cart.positions);
      if ((newMap[product] ?? 0) > 1) {
        newMap.update(
          product,
          (value) => value - 1,
        );
      } else {
        newMap.remove(product);
      }

      state = CartLoaded(
        cart: Cart(positions: newMap),
      );
    } catch (e, st) {
      state = CartFailed(
        cart: state.cart,
        exception: e,
        stackTrace: st,
      );
    }
  }

  Future<void> removePosition({required Product product}) async {
    try {
      await _cartService.removePosition(product: product);
      state = CartLoaded(
        cart: Cart(
          positions: Map.of(state.cart.positions)..remove(product),
        ),
      );
    } catch (e, st) {
      state = CartFailed(
        cart: state.cart,
        exception: e,
        stackTrace: st,
      );
    }
  }

  Future<void> clear() async {
    try {
      await _cartService.clearCart();
      state = const CartLoaded(
        cart: Cart(positions: {}),
      );
    } catch (e, st) {
      state = CartFailed(
        cart: state.cart,
        exception: e,
        stackTrace: st,
      );
    }
  }
}
