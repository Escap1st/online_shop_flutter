import '../../../shared/domain/entities/paged_response.dart';
import 'entities/product.dart';
import 'repositories/product_repository.dart';

abstract interface class ICatalogService {
  Future<PagedResponse<Product>> getProducts({required int offset, required int limit});

  Future<Product> getProduct({required int productId});

  Future<List<String>> getCategories();
}

class CatalogService implements ICatalogService {
  CatalogService({
    required IProductRepository productRepository,
  }) : _productRepository = productRepository;

  final IProductRepository _productRepository;

  @override
  Future<PagedResponse<Product>> getProducts({required int offset, required int limit}) =>
      _productRepository.getProducts(offset: offset, limit: limit);

  @override
  Future<Product> getProduct({required int productId}) =>
      _productRepository.getProduct(productId: productId);

  @override
  Future<List<String>> getCategories() => _productRepository.getCategories();
}
