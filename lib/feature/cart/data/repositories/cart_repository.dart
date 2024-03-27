import '../../../catalog/domain/entities/product.dart';
import '../../domain/entities/cart.dart';
import '../../domain/repositories/cart_repository.dart';

class CartRepository implements ICartRepository {
  @override
  Future<Cart> getCart() async {
    return const Cart(positions: <Product, int>{});
  }

  @override
  Future<void> addItem({required Product product}) async {
    // TODO: implement addItem
  }

  @override
  Future<void> removeItem({required Product product}) async {
    // TODO: implement removeItem
  }

  @override
  Future<void> removePosition({required Product product}) async {
    // TODO: implement removeAllItems
  }

  @override
  Future<void> clearCart() async {
    // TODO: implement clearCart
  }
}
