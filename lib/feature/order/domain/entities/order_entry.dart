import 'package:equatable/equatable.dart';

class OrderEntry extends Equatable {
  const OrderEntry({required this.productId, required this.price, required this.count});

  final int productId;
  final double price;
  final int count;

  @override
  List<Object?> get props => [productId, price, count];
}
