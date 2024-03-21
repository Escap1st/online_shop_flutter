part of 'catalog_provider.dart';

sealed class CatalogState extends Equatable {
  const CatalogState();

  @override
  List<Object?> get props => [];
}

class CatalogLoading extends CatalogState {
  const CatalogLoading();
}

class CatalogLoaded extends CatalogState {
  const CatalogLoaded({required this.products});

  final List<Product> products;

  @override
  List<Object?> get props => [products];

  CatalogLoaded copyWith({
    List<Product>? products,
  }) {
    return CatalogLoaded(
      products: products ?? this.products,
    );
  }
}

class CatalogFailed extends CatalogState {
  const CatalogFailed({required this.exception, required this.stackTrace});

  final Object exception;
  final StackTrace stackTrace;

  @override
  List<Object?> get props => [exception, stackTrace];
}
