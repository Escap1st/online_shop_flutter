import 'package:equatable/equatable.dart';

import 'order_delivery_details.dart';
import 'order_entry.dart';

class Order extends Equatable {
  const Order({
    required this.entries,
    required this.details,
    this.dateTime,
    this.userId,
  });

  final List<OrderEntry> entries;
  final OrderDeliveryDetails details;
  final DateTime? dateTime;
  final String? userId;

  @override
  List<Object?> get props => [entries, details, dateTime, userId];

  Order copyWith({
    List<OrderEntry>? entries,
    OrderDeliveryDetails? details,
    DateTime? dateTime,
    String? userId,
  }) {
    return Order(
      entries: entries ?? this.entries,
      details: details ?? this.details,
      dateTime: dateTime ?? this.dateTime,
      userId: userId ?? this.userId,
    );
  }
}
