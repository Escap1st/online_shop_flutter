import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/di/dependencies.dart';
import '../../../domain/catalog_service.dart';
import '../../../domain/entities/product.dart';

final productDetailsProvider =
    AsyncNotifierProvider.autoDispose.family<ActivityNotifier, Product, int>(
  () => ActivityNotifier(catalogService: resolveDependency()),
);

class ActivityNotifier extends AutoDisposeFamilyAsyncNotifier<Product, int> {
  ActivityNotifier({required ICatalogService catalogService}) : _catalogService = catalogService;

  final ICatalogService _catalogService;

  @override
  Future<Product> build(int arg) async {
    return _catalogService.getProduct(productId: arg);
  }
}
