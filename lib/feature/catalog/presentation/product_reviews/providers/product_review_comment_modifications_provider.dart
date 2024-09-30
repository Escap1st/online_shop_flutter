import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/di/dependencies.dart';
import '../../../domain/catalog_service.dart';
import '../../../domain/entities/set_product_review_comment_request.dart';
import 'product_reviews_provider.dart';

final productReviewCommentModificationsProvider =
    AutoDisposeAsyncNotifierProvider<ProductReviewCommentModificationsNotifier, void>(
  resolveDependency,
);

class ProductReviewCommentModificationsNotifier extends AutoDisposeAsyncNotifier<void> {
  ProductReviewCommentModificationsNotifier({
    required ICatalogService catalogService,
  }) : _catalogService = catalogService;

  final ICatalogService _catalogService;

  @override
  Future<void> build() async {
    return;
  }

  Future<void> create({
    required int productId,
    required String reviewId,
    required String body,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        final comment = await _catalogService.addComment(
          reviewId,
          SetProductReviewCommentRequest(body: body),
        );

        ref.read(productReviewsProvider(productId).notifier).addComment(reviewId, comment);
      },
    );
  }

  Future<void> change({
    required int productId,
    required String reviewId,
    required String commentId,
    required String body,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        final comment = await _catalogService.updateComment(
          commentId,
          SetProductReviewCommentRequest(body: body),
        );

        ref.read(productReviewsProvider(productId).notifier).updateComment(reviewId, comment);
      },
    );
  }

  Future<void> delete({
    required int productId,
    required String reviewId,
    required String commentId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        await _catalogService.deleteComment(commentId);

        ref.read(productReviewsProvider(productId).notifier).deleteComment(reviewId, commentId);
      },
    );
  }
}
