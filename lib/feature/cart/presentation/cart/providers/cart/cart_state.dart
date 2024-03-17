part of 'cart_provider.dart';

sealed class CartState extends Equatable {
  const CartState({required this.cart});

  final Cart cart;

  @override
  List<Object?> get props => [cart];
}

class CartLoading extends CartState {
  const CartLoading({required super.cart});
}

class CartLoaded extends CartState {
  const CartLoaded({required super.cart});
}

class CartFailed extends CartState {
  const CartFailed({required super.cart, required this.exception, required this.stackTrace});

  final Object exception;
  final StackTrace stackTrace;

  @override
  List<Object?> get props => super.props..addAll([exception, stackTrace]);
}
