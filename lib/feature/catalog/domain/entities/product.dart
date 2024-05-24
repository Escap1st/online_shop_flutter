import 'package:equatable/equatable.dart';

import 'product_category.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnailUrl,
    required this.imagesUrls,
  });

  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String? brand;
  final ProductCategory category;
  final String thumbnailUrl;
  final List<String> imagesUrls;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        price,
        discountPercentage,
        rating,
        stock,
        brand,
        category,
        thumbnailUrl,
        imagesUrls,
      ];

  double get originalPrice => price / (100 - discountPercentage) * 100;

  Product copyWith({
    int? id,
    String? title,
    String? description,
    double? price,
    double? discountPercentage,
    double? rating,
    int? stock,
    String? brand,
    ProductCategory? category,
    String? thumbnailUrl,
    List<String>? imagesUrls,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      rating: rating ?? this.rating,
      stock: stock ?? this.stock,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      imagesUrls: imagesUrls ?? this.imagesUrls,
    );
  }
}
