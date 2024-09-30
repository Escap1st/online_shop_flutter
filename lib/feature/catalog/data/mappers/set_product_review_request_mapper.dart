import '../../../../shared/data/mappers/mapper.dart';
import '../../domain/entities/set_product_review_request.dart';
import '../models/set_product_review_request_model.dart';

class SetProductReviewRequestMapper
    implements EntityMapper<SetProductReviewRequest, SetProductReviewRequestModel> {
  @override
  SetProductReviewRequestModel fromEntity(SetProductReviewRequest entity) {
    return SetProductReviewRequestModel(body: entity.body, title: entity.title);
  }

  @override
  SetProductReviewRequest toEntity(SetProductReviewRequestModel model) {
    throw UnimplementedError();
  }
}
