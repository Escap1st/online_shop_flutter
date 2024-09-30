import '../../../../shared/domain/entities/paged_response.dart';
import '../entities/product.dart';
import '../entities/product_category.dart';
import '../entities/product_review.dart';
import '../entities/product_review_comment.dart';
import '../entities/product_review_photo.dart';
import '../entities/set_product_review_comment_request.dart';
import '../entities/set_product_review_request.dart';

abstract interface class IProductRepository {
  Future<PagedResponse<Product>> getProducts({required int offset, required int limit});

  Future<Product> getProduct({required int productId});

  Future<List<ProductCategory>> getCategories();

  Future<List<ProductReview>> getReviews(int productId);

  Future<List<ProductReviewPhoto>> getReviewPhotos(String reviewId);

  Future<ProductReview> addReview(int productId, SetProductReviewRequest request);

  Future<ProductReview> updateReview(String reviewId, SetProductReviewRequest request);

  Future<void> deleteReview(String reviewId);

  Future<ProductReviewComment> addComment(
    String reviewId,
    SetProductReviewCommentRequest request,
  );

  Future<ProductReviewComment> updateComment(
    String commentId,
    SetProductReviewCommentRequest request,
  );

  Future<void> deleteComment(String commentId);
}
