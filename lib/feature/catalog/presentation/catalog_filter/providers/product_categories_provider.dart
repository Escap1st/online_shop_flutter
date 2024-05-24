import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/di/dependencies.dart';
import '../../../domain/catalog_service.dart';
import '../../../domain/entities/product_category.dart';

final productCategoriesProvider =
    AsyncNotifierProvider<ProductCategoriesNotifier, List<ProductCategory>>(resolveDependency);

class ProductCategoriesNotifier extends AsyncNotifier<List<ProductCategory>> {
  ProductCategoriesNotifier({
    required ICatalogService catalogService,
  }) : _catalogService = catalogService;

  final ICatalogService _catalogService;

  @override
  Future<List<ProductCategory>> build() async {
    return _catalogService.getCategories();
  }
}
