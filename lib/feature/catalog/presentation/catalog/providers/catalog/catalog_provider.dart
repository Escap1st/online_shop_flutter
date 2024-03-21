import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/product.dart';
import '../product_list/product_list_provider.dart';

part 'catalog_state.dart';

final catalogProvider = Provider<CatalogState>((ref) {
  final productListState = ref.watch(productListProvider);

  return switch (productListState) {
    ProductListInitial() || ProductListLoading() => const CatalogLoading(),
    ProductListLoaded(:final response) => CatalogLoaded(products: response.items),
    ProductListFailed(:final exception, :final stackTrace) => CatalogFailed(
        exception: exception,
        stackTrace: stackTrace,
      ),
  };
});
