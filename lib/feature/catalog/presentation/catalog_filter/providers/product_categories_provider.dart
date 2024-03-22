import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/di/dependencies.dart';
import '../../../domain/catalog_service.dart';

final productCategoriesProvider =
    AsyncNotifierProvider<ProductCategoriesNotifier, List<String>>(resolveDependency);

class ProductCategoriesNotifier extends AsyncNotifier<List<String>> {
  ProductCategoriesNotifier({
    required ICatalogService catalogService,
  }) : _catalogService = catalogService;

  final ICatalogService _catalogService;

  @override
  Future<List<String>> build() async {
    return _catalogService.getCategories();
  }
}
