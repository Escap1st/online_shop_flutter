import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/product_category_model.dart';
import '../models/product_model.dart';
import '../models/products_paged_response_model.dart';

part 'product_api_client.g.dart';

@RestApi(baseUrl: 'https://dummyjson.com/products')
abstract class IProductApiClient {
  factory IProductApiClient(Dio dio, {String baseUrl}) = _IProductApiClient;

  @GET('')
  Future<ProductsPagedResponseModel> getProductsList({
    @Query('skip') required int offset,
    @Query('limit') required int limit,
  });

  @GET('/{id}')
  Future<ProductModel> getProduct({@Path('id') required int productId});

  @GET('/categories')
  Future<List<ProductCategoryModel>> getCategories();
}
