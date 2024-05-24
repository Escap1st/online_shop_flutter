import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/di/dependencies.dart';
import '../../../../domain/entities/product_category.dart';

part 'catalog_filter_state.dart';

final catalogFilterProvider =
    StateNotifierProvider<CatalogFilterNotifier, CatalogFilterState>((ref) {
  return resolveDependency();
});

class CatalogFilterNotifier extends StateNotifier<CatalogFilterState> {
  CatalogFilterNotifier() : super(const CatalogFilterState());

  void toggleCategory(ProductCategory category) {
    final newCategories = List.of(state.selectedCategories);
    if (!newCategories.remove(category)) {
      newCategories.add(category);
    }
    state = state.copyWith(selectedCategories: newCategories);
  }
}
