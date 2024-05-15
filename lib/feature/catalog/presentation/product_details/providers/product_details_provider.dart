import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/di/dependencies.dart';
import '../../../domain/catalog_service.dart';
import '../../../domain/entities/product.dart';

final productDetailsProvider = AsyncNotifierProvider.autoDispose
    .family<ProductDetailsNotifier, Product, int>(resolveDependency);

class ProductDetailsNotifier extends AutoDisposeFamilyAsyncNotifier<Product, int> {
  ProductDetailsNotifier({
    required ICatalogService catalogService,
  }) : _catalogService = catalogService;

  final ICatalogService _catalogService;

  @override
  Future<Product> build(int arg) {
    return _catalogService.getProduct(productId: arg);
  }
}
