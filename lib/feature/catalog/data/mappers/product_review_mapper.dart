import '../../../../shared/data/mappers/mapper.dart';
import '../../domain/entities/product_review.dart';
import '../models/product_review_model.dart';
import 'product_review_comment_mapper.dart';
import 'product_reviewer_mapper.dart';

class ProductReviewMapper implements EntityMapper<ProductReview, ProductReviewModel> {
  @override
  ProductReviewModel fromEntity(ProductReview entity) {
    throw UnimplementedError();
  }

  @override
  ProductReview toEntity(ProductReviewModel model) {
    return ProductReview(
      id: model.id,
      title: model.title,
      body: model.body,
      user: ProductReviewerMapper().toEntity(model.user),
      comments: model.comments.data.map(ProductReviewCommentMapper().toEntity).toList(),
      photos: const [],
    );
  }
}
