import '../../../../shared/data/mappers/mapper.dart';
import '../../domain/entities/product_review_photo.dart';
import '../models/product_review_photo_model.dart';

class ProductReviewPhotoMapper
    implements EntityMapper<ProductReviewPhoto, ProductReviewPhotoModel> {
  @override
  ProductReviewPhotoModel fromEntity(ProductReviewPhoto entity) {
    throw UnimplementedError();
  }

  @override
  ProductReviewPhoto toEntity(ProductReviewPhotoModel model) {
    return ProductReviewPhoto(url: model.url, thumbnailUrl: model.thumbnailUrl);
  }
}
