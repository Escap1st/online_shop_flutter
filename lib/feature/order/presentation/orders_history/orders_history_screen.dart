import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/order.dart';

class OrdersHistoryScreen extends StatelessWidget {
  const OrdersHistoryScreen({super.key, required this.orders});

  final List<Order>? orders;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders history'),
      ),
      body: SafeArea(
        child: _Loaded(orders: orders!),
      ),
    );
  }
}

class _Loaded extends StatefulWidget {
  const _Loaded({required this.orders, super.key});

  final List<Order> orders;

  @override
  State<_Loaded> createState() => _LoadedState();
}

class _LoadedState extends State<_Loaded> {
  final List<String> _expandedItems = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        children: widget.orders
            .map(
              (e) => ExpansionPanel(
                isExpanded: _expandedItems.contains(e.orderId),
                headerBuilder: (context, expanded) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      '${e.orderId!}, ${DateFormat('dd.MM.yyyy HH:mm:ss').format(e.dateTime!)}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  );
                },
                body: const SizedBox(),
              ),
            )
            .toList(),
        expansionCallback: (index, isExpanded) {
          final id = widget.orders[index].orderId!;
          setState(() => isExpanded ? _expandedItems.add(id) : _expandedItems.remove(id));
        },
        expandedHeaderPadding: EdgeInsets.zero,
      ),
    );
  }
}
