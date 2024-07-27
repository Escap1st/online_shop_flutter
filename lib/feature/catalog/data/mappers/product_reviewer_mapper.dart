import '../../../../shared/data/mappers/mapper.dart';
import '../../domain/entities/product_reviewer.dart';
import '../models/product_reviewer_model.dart';

class ProductReviewerMapper implements EntityMapper<ProductReviewer, ProductReviewerModel> {
  @override
  ProductReviewerModel fromEntity(ProductReviewer entity) {
    throw UnimplementedError();
  }

  @override
  ProductReviewer toEntity(ProductReviewerModel model) {
    return ProductReviewer(
      id: model.id,
      username: model.username,
    );
  }
}
