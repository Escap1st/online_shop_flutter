import '../../../shared/domain/entities/paged_response.dart';
import 'entities/product.dart';
import 'repositories/product_repository.dart';

abstract interface class ICatalogService {
  Future<PagedResponse<Product>> getAllProducts();

  Future<Product> getProduct({required String productId});
}

class CatalogService implements ICatalogService {
  CatalogService({
    required IProductRepository productRepository,
  }) : _productRepository = productRepository;

  final IProductRepository _productRepository;

  @override
  Future<PagedResponse<Product>> getAllProducts() => _productRepository.getAllProducts();

  @override
  Future<Product> getProduct({required String productId}) =>
      _productRepository.getProduct(productId: productId);
}
