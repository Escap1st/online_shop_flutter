import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../shared/presentation/widgets/gap.dart';
import '../../../../shared/presentation/widgets/kit_button.dart';
import '../../../../shared/presentation/widgets/order_summary.dart';
import '../../../../shared/presentation/widgets/screen_error_widget.dart';
import '../../../../shared/presentation/widgets/screen_loading_widget.dart';
import '../../../catalog/domain/entities/product.dart';
import '../../../catalog/presentation/common_providers/products_by_ids_params.dart';
import '../../../catalog/presentation/common_providers/products_by_ids_provider.dart';
import '../../domain/entities/order.dart';
import '../common_providers/orders_provider.dart';
import 'providers/cancel_order_provider.dart';

class OrdersHistoryScreen extends ConsumerWidget {
  const OrdersHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersState = ref.watch(ordersProvider);

    switch (ordersState) {
      case AsyncLoading():
        return const ScreenLoadingWidget();
      case AsyncError(:final error, :final stackTrace):
        return ScreenErrorWidget(
          error: error,
          stackTrace: stackTrace,
          onRetry: () => ref.invalidate(ordersProvider),
          isRetrying: ordersState.isRefreshing,
        );
    }

    final productIds = ordersState.requireValue.fold(
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
        child: switch (productsState) {
          AsyncData(:final value) => _Loaded(
              orders: ordersState.requireValue,
              products: value,
            ),
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

class _Loaded extends ConsumerStatefulWidget {
  const _Loaded({required this.orders, required this.products, super.key});

  final List<Order> orders;
  final List<Product> products;

  @override
  ConsumerState<_Loaded> createState() => _LoadedState();
}

class _LoadedState extends ConsumerState<_Loaded> {
  final List<String> _expandedItems = [];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (widget.orders.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'You have not ordered anything yet',
            style: textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: ExpansionPanelList(
        children: widget.orders
            .map(
              (e) => ExpansionPanel(
                isExpanded: _expandedItems.contains(e.orderId),
                headerBuilder: (context, expanded) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.orderId!,
                          style: textTheme.titleMedium,
                        ),
                        const Gap.v(8),
                        Text(
                          DateFormat('dd.MM.yyyy HH:mm:ss').format(e.dateTime!),
                          style: textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  );
                },
                body: _OrderDetailsBody(
                  order: e,
                  products: widget.products
                      .where(
                        (p) => e.entries.map((orderEntry) => orderEntry.productId).contains(p.id),
                      )
                      .toList(),
                  onCanceled: () => ref.read(ordersProvider.notifier).onOrderCanceled(e.orderId!),
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

class _OrderDetailsBody extends ConsumerWidget {
  const _OrderDetailsBody({
    required this.order,
    required this.products,
    required this.onCanceled,
    super.key,
  });

  final Order order;
  final List<Product> products;
  final VoidCallback onCanceled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = cancelOrderProvider(order.orderId!);
    final state = ref.watch(provider);

    ref.listen(
      provider,
      (previous, next) {
        if (next case AsyncData(:final value) when value) {
          onCanceled();
        }
      },
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        OrderSummary(
          order: order,
          products: products,
          shrinkWrap: true,
        ),
        Container(
          padding: const EdgeInsets.all(16),
          width: double.maxFinite,
          child: KitButton(
            style: KitButtonStyle.negative,
            label: 'Отменить',
            onPressed: ref.read(provider.notifier).cancel,
            isLoading: state is AsyncLoading,
          ),
        )
      ],
    );
  }
}
