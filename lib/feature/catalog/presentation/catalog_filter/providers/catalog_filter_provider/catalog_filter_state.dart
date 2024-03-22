part of 'catalog_filter_provider.dart';

class CatalogFilterState extends Equatable {
  const CatalogFilterState({this.selectedCategories = const []});

  final List<String> selectedCategories;

  int get activeFilters => [
        selectedCategories.isNotEmpty,
      ].where((e) => e).length;

  @override
  List<Object?> get props => [selectedCategories];

  CatalogFilterState copyWith({
    List<String>? selectedCategories,
  }) {
    return CatalogFilterState(
      selectedCategories: selectedCategories ?? this.selectedCategories,
    );
  }
}
