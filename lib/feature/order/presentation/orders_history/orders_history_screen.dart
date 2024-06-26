import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../shared/presentation/widgets/order_summary.dart';
import '../../../../shared/presentation/widgets/screen_error_widget.dart';
import '../../../../shared/presentation/widgets/screen_loading_widget.dart';
import '../../../catalog/domain/entities/product.dart';
import '../../../catalog/presentation/common_providers/products_by_ids_params.dart';
import '../../../catalog/presentation/common_providers/products_by_ids_provider.dart';
import '../../domain/entities/order.dart';

class OrdersHistoryScreen extends ConsumerWidget {
  const OrdersHistoryScreen({super.key, required this.orders});

  final List<Order>? orders;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productIds = orders!.fold(
      <int>{},
      (previousValue, element) => previousValue
        ..addAll(
          element.entries.map((e) => e.productId).toList(),
        ),
    ).toList();
    final providerParams = ProductByIdsParams(ids: productIds);
    final provider = productsByIdsProvider(providerParams);
    final productsState = ref.watch(provider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders history'),
      ),
      body: SafeArea(
        // TODO: load explicitly if null
        child: switch (productsState) {
          AsyncData(:final value) => _Loaded(orders: orders!, products: value),
          AsyncLoading() => const ScreenLoadingWidget(),
          AsyncError(:final error, :final stackTrace) => ScreenErrorWidget(
              error: error,
              stackTrace: stackTrace,
              onRetry: () => ref.invalidate(provider),
              isRetrying: productsState.isRefreshing,
            ),
          _ => const SizedBox.shrink(),
        },
      ),
    );
  }
}

class _Loaded extends StatefulWidget {
  const _Loaded({required this.orders, required this.products, super.key});

  final List<Order> orders;
  final List<Product> products;

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
                body: OrderSummary(
                  order: e,
                  products: widget.products
                      .where(
                        (p) => e.entries.map((orderEntry) => orderEntry.productId).contains(p.id),
                      )
                      .toList(),
                  shrinkWrap: true,
                ),
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
