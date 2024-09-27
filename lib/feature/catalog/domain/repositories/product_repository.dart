import '../../../../shared/domain/entities/paged_response.dart';
import '../entities/product.dart';
import '../entities/product_category.dart';
import '../entities/product_review.dart';
import '../entities/product_review_comment.dart';
import '../entities/product_review_photo.dart';

abstract interface class IProductRepository {
  Future<PagedResponse<Product>> getProducts({required int offset, required int limit});

  Future<Product> getProduct({required int productId});

  Future<List<ProductCategory>> getCategories();

  Future<List<ProductReview>> getReviews(int productId);

  Future<List<ProductReviewPhoto>> getReviewPhotos(String reviewId);

  Future<ProductReview> addReview(int productId, ProductReview review);

  Future<ProductReview> updateReview(ProductReview review);

  Future<void> deleteReview(int reviewId);

  Future<ProductReviewComment> addComment(int reviewId, ProductReviewComment comment);

  Future<ProductReviewComment> updateComment(ProductReviewComment comment);

  Future<void> deleteComment(int commentId);
}
