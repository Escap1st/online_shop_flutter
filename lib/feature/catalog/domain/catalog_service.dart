import 'package:collection/collection.dart';

import '../../../shared/domain/entities/paged_response.dart';
import 'entities/product.dart';
import 'entities/product_category.dart';
import 'repositories/product_repository.dart';

abstract interface class ICatalogService {
  Future<PagedResponse<Product>> getProducts({required int offset, required int limit});

  Future<Product> getProduct({required int productId});

  Future<List<ProductCategory>> getCategories();
}

class CatalogService implements ICatalogService {
  CatalogService({
    required IProductRepository productRepository,
  }) : _productRepository = productRepository;

  final IProductRepository _productRepository;

  @override
  Future<PagedResponse<Product>> getProducts({required int offset, required int limit}) async {
    final products = await _productRepository.getProducts(offset: offset, limit: limit);
    final categories = await getCategories();

    return products.copyWith(
      items: products.items
          .map(
            (e) => e.copyWith(
              category: categories.singleWhereOrNull((c) => c.slug == e.category.slug),
            ),
          )
          .toList(),
    );
  }

  @override
  Future<Product> getProduct({required int productId}) =>
      _productRepository.getProduct(productId: productId);

  @override
  Future<List<ProductCategory>> getCategories() => _productRepository.getCategories();
}
