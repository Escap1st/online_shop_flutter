import '../../../../shared/data/mappers/mapper.dart';
import '../../domain/entities/product_review_comment.dart';
import '../models/product_review_comment_model.dart';

class ProductReviewCommentMapper
    implements EntityMapper<ProductReviewComment, ProductReviewCommentModel> {
  @override
  ProductReviewCommentModel fromEntity(ProductReviewComment entity) {
    throw UnimplementedError();
  }

  @override
  ProductReviewComment toEntity(ProductReviewCommentModel model) {
    return ProductReviewComment(
      id: model.id,
      name: model.name,
      body: model.body,
    );
  }
}
