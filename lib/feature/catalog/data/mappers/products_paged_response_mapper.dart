import '../../../../shared/data/mappers/mapper.dart';
import '../../../../shared/domain/entities/paged_response.dart';
import '../../domain/entities/product.dart';
import '../models/products_paged_response_model.dart';
import 'product_mapper.dart';

class ProductsPagedResponseMapper
    implements EntityMapper<PagedResponse<Product>, ProductsPagedResponseModel> {
  const ProductsPagedResponseMapper();

  @override
  ProductsPagedResponseModel fromEntity(PagedResponse<Product> entity) {
    throw UnimplementedError();
  }

  @override
  PagedResponse<Product> toEntity(ProductsPagedResponseModel model) {
    return PagedResponse(
      items: model.products.map(const ProductMapper().toEntity).toList(),
      total: model.total,
      skip: model.skip,
      limit: model.limit,
    );
  }
}
