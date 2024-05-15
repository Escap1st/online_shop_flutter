import 'package:equatable/equatable.dart';

class OrderDetails extends Equatable {
  const OrderDetails({required this.name, required this.surname, required this.address});

  final String name;
  final String surname;
  final String address;

  @override
  List<Object?> get props => [name, surname, address];
}
