import 'package:equatable/equatable.dart';

import '../../../catalog/domain/entities/product.dart';

class Cart extends Equatable {
  const Cart({required this.items});

  final Map<Product, int> items;

  @override
  List<Object?> get props => [items];
}
