import 'package:equatable/equatable.dart';

class ProductReviewComment extends Equatable {
  const ProductReviewComment({
    required this.id,
    required this.name,
    required this.body,
    this.byCurrentUser = false,
  });

  final String id;
  final String name;
  final String body;
  final bool byCurrentUser;

  @override
  List<Object?> get props => [id, name, body, byCurrentUser];

  ProductReviewComment copyWith({
    String? id,
    String? name,
    String? body,
    bool? byCurrentUser,
  }) {
    return ProductReviewComment(
      id: id ?? this.id,
      name: name ?? this.name,
      body: body ?? this.body,
      byCurrentUser: byCurrentUser ?? this.byCurrentUser,
    );
  }
}
