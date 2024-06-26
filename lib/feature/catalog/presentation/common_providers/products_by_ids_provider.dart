import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/di/dependencies.dart';
import '../../domain/catalog_service.dart';
import '../../domain/entities/product.dart';
import 'products_by_ids_params.dart';

final productsByIdsProvider = AsyncNotifierProvider.autoDispose
    .family<ProductsByIdsNotifier, List<Product>, ProductByIdsParams>(resolveDependency);

class ProductsByIdsNotifier
    extends AutoDisposeFamilyAsyncNotifier<List<Product>, ProductByIdsParams> {
  ProductsByIdsNotifier({
    required ICatalogService catalogService,
  }) : _catalogService = catalogService;

  final ICatalogService _catalogService;

  @override
  Future<List<Product>> build(ProductByIdsParams arg) {
    return _catalogService.getProductsByIds(productsIds: arg.ids);
  }
}
