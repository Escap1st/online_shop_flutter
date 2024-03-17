import '../../../catalog/domain/entities/product.dart';
import '../entities/cart.dart';

abstract interface class ICartRepository {
  Future<Cart> getCart();

  Future<void> addItem({required Product product});

  Future<void> removeItem({required Product product});

  Future<void> removePosition({required Product product});

  Future<void> clearCart();
}
