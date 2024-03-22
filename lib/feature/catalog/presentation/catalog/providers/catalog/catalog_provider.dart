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
      ProductListLoaded(:final response) => CatalogLoaded(
          products: _filterItems(response.items, catalogFilterState),
        ),
      ProductListFailed(:final exception, :final stackTrace) => CatalogFailed(
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
}
