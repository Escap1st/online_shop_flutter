import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/di/dependencies.dart';
import '../../../domain/catalog_service.dart';
import '../../../domain/entities/product_review.dart';

final productReviewsProvider = AsyncNotifierProvider.autoDispose
    .family<ProductReviewsNotifier, List<ProductReview>, int>(resolveDependency);

class ProductReviewsNotifier extends AutoDisposeFamilyAsyncNotifier<List<ProductReview>, int> {
  ProductReviewsNotifier({
    required ICatalogService catalogService,
  }) : _catalogService = catalogService;

  final ICatalogService _catalogService;

  @override
  Future<List<ProductReview>> build(int arg) {
    return _catalogService.getReviews(productId: arg);
  }
}
