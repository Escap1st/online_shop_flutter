part of 'product_list_provider.dart';

sealed class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object?> get props => [];
}

class ProductListInitial extends ProductListState {
  const ProductListInitial();
}

class ProductListLoading extends ProductListState {
  const ProductListLoading();
}

class ProductListLoaded extends ProductListState {
  const ProductListLoaded({required this.products, required this.isPaginationAvailable});

  final List<Product> products;
  final bool isPaginationAvailable;

  @override
  List<Object?> get props => [products, isPaginationAvailable];
}

class ProductListFailed extends ProductListState {
  const ProductListFailed({
    required this.exception,
    required this.stackTrace,
    this.isReloading = false,
  });

  final Object exception;
  final StackTrace stackTrace;
  final bool isReloading;

  @override
  List<Object?> get props => [exception, stackTrace, isReloading];

  ProductListFailed copyWith({
    Object? exception,
    StackTrace? stackTrace,
    bool? isReloading,
  }) {
    return ProductListFailed(
      exception: exception ?? this.exception,
      stackTrace: stackTrace ?? this.stackTrace,
      isReloading: isReloading ?? this.isReloading,
    );
  }
}

class ProductListPaginating extends ProductListState {
  const ProductListPaginating({required this.products});

  final List<Product> products;

  @override
  List<Object?> get props => [products];
}

class ProductListPaginationFailed extends ProductListState {
  const ProductListPaginationFailed({
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
