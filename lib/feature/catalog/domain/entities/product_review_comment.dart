import 'package:equatable/equatable.dart';

class ProductReviewComment extends Equatable {
  const ProductReviewComment({required this.id, required this.name, required this.body});

  final String id;
  final String name;
  final String body;

  @override
  List<Object?> get props => [id, name, body];
}
