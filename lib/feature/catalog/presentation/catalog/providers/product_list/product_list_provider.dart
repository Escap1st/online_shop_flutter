import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/di/dependencies.dart';
import '../../../../../../shared/domain/entities/paged_response.dart';
import '../../../../domain/catalog_service.dart';
import '../../../../domain/entities/product.dart';

part 'product_list_state.dart';

final productListProvider = StateNotifierProvider<ProductListNotifier, ProductListState>(
  (ref) => resolveDependency(),
);

class ProductListNotifier extends StateNotifier<ProductListState> {
  ProductListNotifier({required ICatalogService catalogService})
      : _catalogService = catalogService,
        super(const ProductListInitial()) {
    load();
  }

  final ICatalogService _catalogService;

  Future<void> load() async {
    state = const ProductListLoading();

    try {
      final response = await _catalogService.getAllProducts();
      state = ProductListLoaded(response: response);
    } catch (e, st) {
      state = ProductListFailed(exception: e, stackTrace: st);
    }
  }

  Future<void> reload() async {
    state = state is ProductListFailed
        ? (state as ProductListFailed).copyWith(isReloading: true)
        : const ProductListLoading();

    try {
      final response = await _catalogService.getAllProducts();
      state = ProductListLoaded(response: response);
    } catch (e, st) {
      state = ProductListFailed(exception: e, stackTrace: st);
    }
  }
}
