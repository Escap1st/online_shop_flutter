import '../../../../shared/data/mappers/mapper.dart';
import '../../domain/entities/product_category.dart';
import '../models/product_category_model.dart';

class ProductCategoryMapper implements EntityMapper<ProductCategory, ProductCategoryModel> {
  @override
  ProductCategoryModel fromEntity(ProductCategory entity) {
    throw UnimplementedError();
  }

  @override
  ProductCategory toEntity(ProductCategoryModel model) {
    return ProductCategory(slug: model.slug, name: model.name);
  }
}
