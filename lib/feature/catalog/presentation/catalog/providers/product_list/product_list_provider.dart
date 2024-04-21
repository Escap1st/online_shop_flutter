import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/di/dependencies.dart';
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

  static const _kLimit = 30;

  final ICatalogService _catalogService;

  Future<void> load() async {
    state = const ProductListLoading();

    try {
      final response = await _catalogService.getProducts(offset: 0, limit: _kLimit);
      state = ProductListLoaded(
        products: response.items,
        isPaginationAvailable: response.items.length < response.total,
      );
    } catch (e, st) {
      state = ProductListFailed(exception: e, stackTrace: st);
    }
  }

  Future<void> reload() async {
    state = state is ProductListFailed
        ? (state as ProductListFailed).copyWith(isReloading: true)
        : const ProductListLoading();

    try {
      final response = await _catalogService.getProducts(offset: 0, limit: _kLimit);
      state = ProductListLoaded(
        products: response.items,
        isPaginationAvailable: response.items.length < response.total,
      );
    } catch (e, st) {
      state = ProductListFailed(exception: e, stackTrace: st);
    }
  }

  Future<void> getNextPage() async {
    final List<Product> currentProducts;
    switch (state) {
      case ProductListLoaded(:final products):
      case ProductListPaginationFailed(:final products):
        currentProducts = products;
      default:
        return;
    }

    state = ProductListPaginating(products: currentProducts);

    try {
      final response = await _catalogService.getProducts(
        offset: currentProducts.length,
        limit: _kLimit,
      );
      final newProducts = [
        ...currentProducts,
        ...response.items,
      ];
      state = ProductListLoaded(
        products: newProducts,
        isPaginationAvailable: newProducts.length < response.total,
      );
    } catch (e, st) {
      state = ProductListPaginationFailed(products: currentProducts, exception: e, stackTrace: st);
    }
  }
}
