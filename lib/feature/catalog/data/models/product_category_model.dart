import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/typedefs.dart';

part 'product_category_model.g.dart';

@JsonSerializable()
class ProductCategoryModel {
  ProductCategoryModel({required this.slug, required this.name, required this.url});

  factory ProductCategoryModel.fromJson(Json json) => _$ProductCategoryModelFromJson(json);

  final String slug;
  final String name;
  final String url;

  Json toJson() => _$ProductCategoryModelToJson(this);
}
