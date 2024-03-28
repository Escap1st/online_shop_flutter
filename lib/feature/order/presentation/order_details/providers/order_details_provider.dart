import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderDetailsProvider = StateProvider<OrderDetailsState?>((ref) => null);

class OrderDetailsState {
  OrderDetailsState({
    required this.name,
    required this.surname,
    required this.address,
  });

  final String name;
  final String surname;
  final String address;
}
