import 'package:equatable/equatable.dart';

import 'product_review_comment.dart';
import 'product_review_photo.dart';
import 'product_reviewer.dart';

class ProductReview extends Equatable {
  const ProductReview({
    required this.id,
    required this.title,
    required this.body,
    required this.user,
    required this.comments,
    required this.photos,
    this.byCurrentUser = false,
  });

  final String id;
  final String title;
  final String body;
  final ProductReviewer? user;
  final List<ProductReviewComment>? comments;
  final List<ProductReviewPhoto>? photos;
  final bool byCurrentUser;

  @override
  List<Object?> get props => [id, title, body, user, comments, photos, byCurrentUser];

  ProductReview copyWith({
    String? id,
    String? title,
    String? body,
    ProductReviewer? user,
    List<ProductReviewComment>? comments,
    List<ProductReviewPhoto>? photos,
    bool? byCurrentUser,
  }) {
    return ProductReview(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      user: user ?? this.user,
      comments: comments ?? this.comments,
      photos: photos ?? this.photos,
      byCurrentUser: byCurrentUser ?? this.byCurrentUser,
    );
  }
}
