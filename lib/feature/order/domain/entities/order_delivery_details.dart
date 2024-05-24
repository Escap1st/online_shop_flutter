import 'package:equatable/equatable.dart';

class OrderDeliveryDetails extends Equatable {
  const OrderDeliveryDetails({
    required this.name,
    required this.surname,
    required this.address,
  });

  final String name;
  final String surname;
  final String address;

  @override
  List<Object?> get props => [name, surname, address];
}
