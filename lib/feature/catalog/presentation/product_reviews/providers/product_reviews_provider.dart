import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/di/dependencies.dart';
import '../../../domain/catalog_service.dart';
import '../../../domain/entities/product_review.dart';
import '../../../domain/entities/product_review_comment.dart';

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

  void addReview(ProductReview review) {
    state = AsyncData([...state.requireValue, review]);
  }

  void updateReview(ProductReview review) {
    state = AsyncData(
      state.requireValue.map((e) => review.id == e.id ? review : e).toList(),
    );
  }

  void deleteReview(String reviewId) {
    state = AsyncData(
      List.of(state.requireValue)..removeWhere((e) => e.id == reviewId),
    );
  }

  void addComment(String reviewId, ProductReviewComment comment) {
    state = AsyncData(
      state.requireValue
          .map((e) => reviewId == e.id ? e.copyWith(comments: [...?e.comments, comment]) : e)
          .toList(),
    );
  }

  void updateComment(String reviewId, ProductReviewComment comment) {
    state = AsyncData(
      state.requireValue
          .map(
            (e) => e.copyWith(
              comments: e.id == reviewId
                  ? e.comments
                      ?.map(
                        (c) => c.id == comment.id ? comment : c,
                      )
                      .toList()
                  : null,
            ),
          )
          .toList(),
    );
  }

  void deleteComment(String reviewId, String commentId) {
    state = AsyncData(
      List.of(state.requireValue)
        ..forEach((e) {
          if (e.id == reviewId) {
            e.comments?.removeWhere((c) => c.id == commentId);
          }
        }),
    );
  }
}
