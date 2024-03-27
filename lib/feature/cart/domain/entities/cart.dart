import 'package:equatable/equatable.dart';

import '../../../catalog/domain/entities/product.dart';

class Cart extends Equatable {
  const Cart({required this.positions});

  final Map<Product, int> positions;

  @override
  List<Object?> get props => [positions];

  int get items => positions.values.reduce((value, element) => value + element);

  double get totalSum {
    var sum = 0.0;
    positions.forEach((key, value) {
      sum += key.price * value;
    });
    return sum;
  }
}
