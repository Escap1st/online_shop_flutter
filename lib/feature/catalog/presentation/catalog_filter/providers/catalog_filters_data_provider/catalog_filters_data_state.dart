part of 'catalog_filters_data_provider.dart';

class CatalogFiltersDataState extends Equatable {
  const CatalogFiltersDataState({required this.categories});

  final List<String> categories;

  @override
  List<Object?> get props => [categories];
}
