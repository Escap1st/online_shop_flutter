import '../../../../shared/data/mappers/mapper.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_category.dart';
import '../models/product_model.dart';

class ProductMapper implements EntityMapper<Product, ProductModel> {
  const ProductMapper();

  @override
  ProductModel fromEntity(Product entity) {
    throw UnimplementedError();
  }

  @override
  Product toEntity(ProductModel model) {
    return Product(
      id: model.id,
      title: model.title,
      description: model.description,
      price: model.price,
      discountPercentage: model.discountPercentage,
      rating: model.rating,
      stock: model.stock,
      brand: model.brand,
      category: ProductCategory(slug: model.category, name: ''),
      thumbnailUrl: model.thumbnail,
      imagesUrls: model.images,
    );
  }
}
