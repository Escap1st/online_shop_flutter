part of 'catalog_filter_provider.dart';

class CatalogFilterState extends Equatable {
  const CatalogFilterState({this.selectedCategories = const []});

  final List<ProductCategory> selectedCategories;

  int get activeFilters => [
        selectedCategories.isNotEmpty,
      ].where((e) => e).length;

  @override
  List<Object?> get props => [selectedCategories];

  CatalogFilterState copyWith({
    List<ProductCategory>? selectedCategories,
  }) {
    return CatalogFilterState(
      selectedCategories: selectedCategories ?? this.selectedCategories,
    );
  }
}
