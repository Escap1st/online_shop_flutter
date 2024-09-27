import 'package:collection/collection.dart';

import '../../../shared/domain/entities/paged_response.dart';
import 'entities/product.dart';
import 'entities/product_category.dart';
import 'entities/product_review.dart';
import 'entities/product_review_comment.dart';
import 'repositories/product_repository.dart';

abstract interface class ICatalogService {
  Future<PagedResponse<Product>> getProducts({required int offset, required int limit});

  Future<List<Product>> getProductsByIds({required List<int> productsIds});

  Future<Product> getProduct({required int productId});

  Future<List<ProductCategory>> getCategories();

  Future<List<ProductReview>> getReviews({required int productId});

  Future<ProductReview> addReview(int productId, ProductReview review);

  Future<ProductReview> updateReview(ProductReview review);

  Future<void> deleteReview(int reviewId);

  Future<ProductReviewComment> addComment(int reviewId, ProductReviewComment comment);

  Future<ProductReviewComment> updateComment(ProductReviewComment comment);

  Future<void> deleteComment(int commentId);
}

class CatalogService implements ICatalogService {
  CatalogService({
    required IProductRepository productRepository,
  }) : _productRepository = productRepository;

  final IProductRepository _productRepository;

  @override
  Future<PagedResponse<Product>> getProducts({required int offset, required int limit}) async {
    final products = await _productRepository.getProducts(offset: offset, limit: limit);
    final categories = await getCategories();

    return products.copyWith(
      items: products.items
          .map(
            (e) => e.copyWith(
              category: categories.singleWhereOrNull((c) => c.slug == e.category.slug),
            ),
          )
          .toList(),
    );
  }

  @override
  Future<List<Product>> getProductsByIds({required List<int> productsIds}) async {
    final result = <Product>[];
    for (final id in productsIds) {
      result.add(
        await getProduct(productId: id),
      );
    }
    return result;
  }

  @override
  Future<Product> getProduct({required int productId}) =>
      _productRepository.getProduct(productId: productId);

  @override
  Future<List<ProductCategory>> getCategories() => _productRepository.getCategories();

  @override
  Future<List<ProductReview>> getReviews({required int productId}) async {
    final reviews = await _productRepository.getReviews(productId);
    for (var i = 0; i < reviews.length; i++) {
      reviews[i] = reviews[i].copyWith(
        photos: await _productRepository.getReviewPhotos(
          reviews[i].id,
        ),
      );
    }
    return reviews;
  }

  @override
  Future<ProductReviewComment> addComment(int reviewId, ProductReviewComment comment) =>
      _productRepository.addComment(reviewId, comment);

  @override
  Future<ProductReview> addReview(int productId, ProductReview review) =>
      _productRepository.addReview(productId, review);

  @override
  Future<void> deleteComment(int commentId) => _productRepository.deleteComment(commentId);

  @override
  Future<void> deleteReview(int reviewId) => _productRepository.deleteReview(reviewId);

  @override
  Future<ProductReviewComment> updateComment(ProductReviewComment comment) =>
      _productRepository.updateComment(comment);

  @override
  Future<ProductReview> updateReview(ProductReview review) =>
      _productRepository.updateReview(review);
}
