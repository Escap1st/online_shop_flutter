import 'package:equatable/equatable.dart';

class ProductComment extends Equatable {
  const ProductComment({
    required this.id,
    required this.productId,
    required this.userId,
    required this.body,
  });

  final int id;
  final int productId;
  final int userId;
  final String body;

  @override
  List<Object?> get props => [id, productId, userId, body];
}
