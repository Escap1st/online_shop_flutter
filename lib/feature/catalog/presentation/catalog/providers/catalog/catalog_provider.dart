import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/di/dependencies.dart';
import '../../../../domain/entities/product.dart';
import '../../../catalog_filter/providers/catalog_filter_provider/catalog_filter_provider.dart';
import '../product_list/product_list_provider.dart';

part 'catalog_state.dart';

final catalogProvider = NotifierProvider<CatalogNotifier, CatalogState>(resolveDependency);

class CatalogNotifier extends Notifier<CatalogState> {
  @override
  CatalogState build() {
    final productListState = ref.watch(productListProvider);
    final catalogFilterState = ref.watch(catalogFilterProvider);

    return switch (productListState) {
      ProductListInitial() || ProductListLoading() => const CatalogLoading(),
      ProductListLoaded(:final products, :final isPaginationAvailable) => CatalogLoaded(
          products: _filterItems(products, catalogFilterState),
          isPaginationAvailable: isPaginationAvailable,
        ),
      ProductListFailed(:final exception, :final stackTrace, :final isReloading) => CatalogFailed(
          exception: exception,
          stackTrace: stackTrace,
          isReloading: isReloading,
        ),
      ProductListPaginating(:final products) => CatalogPaginating(products: products),
      ProductListPaginationFailed(:final products, :final exception, :final stackTrace) =>
        CatalogPaginationFailed(
          products: products,
          exception: exception,
          stackTrace: stackTrace,
        ),
    };
  }

  List<Product> _filterItems(List<Product> items, CatalogFilterState filterState) {
    return filterState.selectedCategories.isEmpty
        ? items
        : items.where((e) => filterState.selectedCategories.contains(e.category)).toList();
  }

  void reload() {
    ref.read(productListProvider.notifier).reload();
  }

  void getNextPage() {
    ref.read(productListProvider.notifier).getNextPage();
  }
}
