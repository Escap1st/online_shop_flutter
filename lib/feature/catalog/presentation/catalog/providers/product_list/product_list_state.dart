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
  const ProductListLoaded({required this.response});

  final PagedResponse<Product> response;

  @override
  List<Object?> get props => [response];

  ProductListLoaded copyWith({
    PagedResponse<Product>? response,
  }) {
    return ProductListLoaded(
      response: response ?? this.response,
    );
  }
}

class ProductListFailed extends ProductListState {
  const ProductListFailed({required this.exception, required this.stackTrace});

  final Object exception;
  final StackTrace stackTrace;

  @override
  List<Object?> get props => [exception, stackTrace];
}
