import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/typedefs.dart';
import '../../../../shared/data/models/paged_response_model.dart';
import 'product_model.dart';

part 'products_paged_response_model.g.dart';

@JsonSerializable()
class ProductsPagedResponseModel extends PagedResponseModel {
  ProductsPagedResponseModel({
    required super.total,
    required super.skip,
    required super.limit,
    required this.products,
  });

  factory ProductsPagedResponseModel.fromJson(Json json) =>
      _$ProductsPagedResponseModelFromJson(json);

  final List<ProductModel> products;

  Json toJson() => _$ProductsPagedResponseModelToJson(this);
}
