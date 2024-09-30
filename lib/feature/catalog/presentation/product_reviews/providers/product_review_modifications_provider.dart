import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/di/dependencies.dart';
import '../../../domain/catalog_service.dart';
import '../../../domain/entities/set_product_review_request.dart';
import 'product_reviews_provider.dart';

final productReviewModificationsProvider =
    AutoDisposeAsyncNotifierProvider<ProductReviewModificationsNotifier, void>(resolveDependency);

class ProductReviewModificationsNotifier extends AutoDisposeAsyncNotifier<void> {
  ProductReviewModificationsNotifier({
    required ICatalogService catalogService,
  }) : _catalogService = catalogService;

  final ICatalogService _catalogService;

  @override
  Future<void> build() async {
    return;
  }

  Future<void> create({
    required int productId,
    required String title,
    required String body,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        final review = await _catalogService.addReview(
          productId,
          SetProductReviewRequest(title: title, body: body),
        );

        ref.read(productReviewsProvider(productId).notifier).addReview(review);
      },
    );
  }

  Future<void> change({
    required int productId,
    required String reviewId,
    required String title,
    required String body,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        final review = await _catalogService.updateReview(
          reviewId,
          SetProductReviewRequest(title: title, body: body),
        );

        ref.read(productReviewsProvider(productId).notifier).updateReview(review);
      },
    );
  }

  Future<void> delete({
    required int productId,
    required String reviewId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        await _catalogService.deleteReview(reviewId);

        ref.read(productReviewsProvider(productId).notifier).deleteReview(reviewId);
      },
    );
  }
}
