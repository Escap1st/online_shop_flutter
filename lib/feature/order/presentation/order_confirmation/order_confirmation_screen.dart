import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/dependencies.dart';
import '../../../../core/error_handler.dart';
import '../../../../core/routing/routes.dart';
import '../../../../shared/presentation/widgets/gap.dart';
import '../../../../shared/presentation/widgets/kit_button.dart';
import '../../../../shared/presentation/widgets/order_summary.dart';
import '../../../cart/presentation/cart/providers/cart/cart_provider.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/order_entry.dart';
import '../common_providers/orders_provider.dart';
import '../delivery_details/providers/delivery_details_provider.dart';
import 'providers/order_confirmation_provider.dart';

class OrderConfirmationScreen extends ConsumerWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.read(cartProvider).cart;
    final orderDetails = ref.read(deliveryDetailsProvider);
    final order = Order(
      entries: cart.positions.entries
          .map(
            (e) => OrderEntry(
              productId: e.key.id,
              price: e.key.price,
              count: e.value,
            ),
          )
          .toList(),
      details: orderDetails!,
    );

    final confirmationProvider = orderConfirmationProvider(order);
    final confirmationState = ref.watch(confirmationProvider);
    ref.listen(
      confirmationProvider,
      (previous, next) {
        if (next case AsyncData(:final value) when value) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => _Dialog(
              onConfirm: () {
                const CatalogRoute().go(context);
                ref.invalidate(cartProvider);
              },
            ),
          );
        } else if (next is AsyncError) {
          resolveDependency<IErrorHandler>().showNotification(
            context,
            error: next.error!,
            stackTrace: next.stackTrace,
          );
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order confirmation'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                child: OrderSummary(
                  order: order,
                  products: cart.positions.keys.toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: KitButton(
                label: 'Confirm',
                isLoading: confirmationState is AsyncLoading,
                onPressed: () {
                  ref.read(confirmationProvider.notifier).confirm();
                  ref.invalidate(ordersProvider);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Dialog extends StatelessWidget {
  const _Dialog({super.key, required this.onConfirm});

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopScope(
      canPop: false,
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 48,
                color: theme.colorScheme.secondary,
              ),
              const Gap.v(12),
              Text(
                'Your order has been placed, thank you!',
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const Gap.v(12),
              KitButton(
                label: 'Continue shopping',
                onPressed: onConfirm,
              )
            ],
          ),
        ),
      ),
    );
  }
}
