import '../../../../shared/domain/entities/paged_response.dart';
import '../entities/product.dart';
import '../entities/product_category.dart';
import '../entities/product_review.dart';
import '../entities/product_review_photo.dart';

abstract interface class IProductRepository {
  Future<PagedResponse<Product>> getProducts({required int offset, required int limit});

  Future<Product> getProduct({required int productId});

  Future<List<ProductCategory>> getCategories();

  Future<List<ProductReview>> getReviews(int productId);

  Future<List<ProductReviewPhoto>> getReviewPhotos(String reviewId);
}
