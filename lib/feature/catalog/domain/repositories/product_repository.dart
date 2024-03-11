import '../../../../shared/domain/entities/paged_response.dart';
import '../entities/product.dart';

abstract interface class IProductRepository {
  Future<PagedResponse<Product>> getAllProducts();

  Future<Product> getProduct({required String productId});
}
