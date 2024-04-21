import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/di/dependencies.dart';
import '../product_categories_provider.dart';

part 'catalog_filters_data_state.dart';

final catalogFiltersDataProvider =
    NotifierProvider<CatalogFiltersDataNotifier, AsyncValue<CatalogFiltersDataState>>(
  resolveDependency,
);

class CatalogFiltersDataNotifier extends Notifier<AsyncValue<CatalogFiltersDataState>> {
  @override
  AsyncValue<CatalogFiltersDataState> build() {
    final productCategories = ref.watch(productCategoriesProvider);
    final states = <AsyncValue<dynamic>>[productCategories];

    if (states.any((e) => e is AsyncError)) {
      final first = states.firstWhere((e) => e is AsyncError).asError!;
      final newError = AsyncValue<CatalogFiltersDataState>.error(first.error, first.stackTrace);
      return first.isRefreshing
          ? const AsyncLoading<CatalogFiltersDataState>().copyWithPrevious(newError)
          : newError;
    } else if (states.any((e) => e is AsyncLoading)) {
      return const AsyncLoading();
    } else {
      return AsyncValue.data(
        CatalogFiltersDataState(categories: productCategories.value!),
      );
    }
  }

  void invalidate() {
    ref.invalidate(productCategoriesProvider);
  }
}
