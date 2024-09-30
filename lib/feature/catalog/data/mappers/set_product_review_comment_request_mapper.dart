import '../../../../shared/data/mappers/mapper.dart';
import '../../domain/entities/set_product_review_comment_request.dart';
import '../models/set_product_review_comment_request_model.dart';

class SetProductReviewCommentRequestMapper
    implements EntityMapper<SetProductReviewCommentRequest, SetProductReviewCommentRequestModel> {
  @override
  SetProductReviewCommentRequestModel fromEntity(SetProductReviewCommentRequest entity) {
    return SetProductReviewCommentRequestModel(
      name: entity.name,
      body: entity.body,
      email: entity.email,
    );
  }

  @override
  SetProductReviewCommentRequest toEntity(SetProductReviewCommentRequestModel model) {
    throw UnimplementedError();
  }
}
