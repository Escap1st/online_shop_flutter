import 'package:equatable/equatable.dart';

class ProductReviewer extends Equatable {
  const ProductReviewer({required this.id, required this.username});

  final String id;
  final String username;

  @override
  List<Object?> get props => [id, username];
}
