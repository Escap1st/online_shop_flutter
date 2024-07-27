import 'package:equatable/equatable.dart';

class ProductReviewPhoto extends Equatable {
  const ProductReviewPhoto({required this.url, required this.thumbnailUrl});

  final String url;
  final String thumbnailUrl;

  @override
  List<Object?> get props => [url, thumbnailUrl];
}
