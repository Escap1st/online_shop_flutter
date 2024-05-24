import 'package:equatable/equatable.dart';

class ProductCategory extends Equatable {
  const ProductCategory({required this.slug, required this.name});

  final String slug;
  final String name;

  @override
  List<Object?> get props => [slug, name];

  ProductCategory copyWith({
    String? slug,
    String? name,
  }) {
    return ProductCategory(
      slug: slug ?? this.slug,
      name: name ?? this.name,
    );
  }
}
