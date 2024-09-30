import 'package:collection/collection.dart';

import '../../../shared/domain/entities/paged_response.dart';
import '../../authentication/domain/repositories/authentication_repository.dart';
import 'entities/product.dart';
import 'entities/product_category.dart';
import 'entities/product_review.dart';
import 'entities/product_review_comment.dart';
import 'entities/product_reviewer.dart';
import 'entities/set_product_review_comment_request.dart';
import 'entities/set_product_review_request.dart';
import 'repositories/product_repository.dart';

abstract interface class ICatalogService {
  Future<PagedResponse<Product>> getProducts({required int offset, required int limit});

  Future<List<Product>> getProductsByIds({required List<int> productsIds});

  Future<Product> getProduct({required int productId});

  Future<List<ProductCategory>> getCategories();

  Future<List<ProductReview>> getReviews({required int productId});

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

class CatalogService implements ICatalogService {
  CatalogService({
    required IProductRepository productRepository,
    required IAuthenticationRepository authenticationRepository,
  })  : _productRepository = productRepository,
        _authenticationRepository = authenticationRepository;

  final IProductRepository _productRepository;
  final IAuthenticationRepository _authenticationRepository;

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
  Future<ProductReviewComment> addComment(
    String reviewId,
    SetProductReviewCommentRequest request,
  ) async {
    final login = await _authenticationRepository.getLogin() ?? 'Anonymous';
    final comment = await _productRepository.addComment(
      reviewId,
      request.copyWith(name: login),
    );
    return comment.copyWith(byCurrentUser: true);
  }

  @override
  Future<ProductReview> addReview(int productId, SetProductReviewRequest request) async {
    final review = await _productRepository.addReview(productId, request);
    return _addUserInfoToReview(review);
  }

  @override
  Future<void> deleteComment(String commentId) =>
      _productRepository.deleteComment(commentId);

  @override
  Future<void> deleteReview(String reviewId) => _productRepository.deleteReview(reviewId);

  @override
  Future<ProductReviewComment> updateComment(
    String commentId,
    SetProductReviewCommentRequest request,
  ) async {
    final login = await _authenticationRepository.getLogin() ?? 'Anonymous';
    final comment = await _productRepository.updateComment(
      commentId,
      request.copyWith(name: login),
    );
    return comment.copyWith(byCurrentUser: true);
  }

  @override
  Future<ProductReview> updateReview(String reviewId, SetProductReviewRequest request) async {
    final review = await _productRepository.updateReview(reviewId, request);
    return _addUserInfoToReview(review);
  }

  Future<ProductReview> _addUserInfoToReview(ProductReview review) async {
    final id = await _authenticationRepository.getUserId();
    final login = await _authenticationRepository.getLogin();

    return id != null && login != null
        ? review.copyWith(
            user: ProductReviewer(id: id, username: login),
            byCurrentUser: true,
          )
        : review;
  }
}
