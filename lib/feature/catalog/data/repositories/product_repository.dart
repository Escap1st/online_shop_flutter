import 'dart:core';

import '../../../../core/network/network_call_error_handling.dart';
import '../../../../shared/domain/entities/paged_response.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../api_clients/product_api_client.dart';
import '../mappers/product_mapper.dart';
import '../mappers/products_paged_response_mapper.dart';

class ProductRepository implements IProductRepository {
  ProductRepository({
    required IProductApiClient productApiClient,
  }) : _productApiClient = productApiClient;

  final IProductApiClient _productApiClient;

  @override
  Future<PagedResponse<Product>> getProducts({required int offset, required int limit}) async {
    final pagedResponseModel = await _productApiClient
        .getProductsList(
          offset: offset,
          limit: limit,
        )
        .handleErrors();
    return const ProductsPagedResponseMapper().toEntity(pagedResponseModel);
  }

  @override
  Future<Product> getProduct({required int productId}) async {
    final productModel = await _productApiClient.getProduct(productId: productId).handleErrors();
    return const ProductMapper().toEntity(productModel);
  }

  @override
  Future<List<String>> getCategories() async {
    return _productApiClient.getCategories().handleErrors();
  }
}
