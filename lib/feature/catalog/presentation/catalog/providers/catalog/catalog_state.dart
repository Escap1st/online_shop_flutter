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
  const CatalogLoaded({required this.products, required this.isPaginationAvailable});

  final List<Product> products;
  final bool isPaginationAvailable;

  @override
  List<Object?> get props => [products, isPaginationAvailable];
}

class CatalogFailed extends CatalogState {
  const CatalogFailed({
    required this.exception,
    required this.stackTrace,
    this.isReloading = false,
  });

  final Object exception;
  final StackTrace stackTrace;
  final bool isReloading;

  @override
  List<Object?> get props => [exception, stackTrace, isReloading];
}

class CatalogPaginating extends CatalogState {
  const CatalogPaginating({required this.products});

  final List<Product> products;

  @override
  List<Object?> get props => [products];
}

class CatalogPaginationFailed extends CatalogState {
  const CatalogPaginationFailed({
    required this.products,
    required this.exception,
    required this.stackTrace,
  });

  final List<Product> products;
  final Object exception;
  final StackTrace stackTrace;

  @override
  List<Object?> get props => [products, exception, stackTrace];
}
