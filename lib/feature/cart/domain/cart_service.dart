import '../../catalog/domain/entities/product.dart';
import 'entities/cart.dart';
import 'repositories/cart_repository.dart';

abstract interface class ICartService {
  Future<Cart> getCart();

  Future<void> addItem({required Product product});

  Future<void> removeItem({required Product product});

  Future<void> removePosition({required Product product});

  Future<void> clearCart();
}

class CartService implements ICartService {
  CartService({
    required ICartRepository cartRepository,
  }) : _cartRepository = cartRepository;

  final ICartRepository _cartRepository;

  @override
  Future<Cart> getCart() => _cartRepository.getCart();

  @override
  Future<void> addItem({required Product product}) => _cartRepository.addItem(product: product);

  @override
  Future<void> removeItem({required Product product}) =>
      _cartRepository.removeItem(product: product);

  @override
  Future<void> removePosition({required Product product}) =>
      _cartRepository.removePosition(product: product);

  @override
  Future<void> clearCart() => _cartRepository.clearCart();
}
