import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/dependencies.dart';
import '../../../../core/error_handler.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/iterable.dart';
import '../../../../shared/presentation/widgets/fading_edge_scroll_view.dart';
import '../../../../shared/presentation/widgets/gap.dart';
import '../../../../shared/presentation/widgets/kit_button.dart';
import '../../../cart/presentation/cart/providers/cart/cart_provider.dart';
import '../../../catalog/domain/entities/product.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/order_entry.dart';
import '../order_details/providers/order_details_provider.dart';
import 'providers/order_confirmation_provider.dart';

class OrderConfirmationScreen extends ConsumerWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.read(cartProvider).cart;
    final orderDetails = ref.read(orderDetailsProvider);
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
        if (next is AsyncData && next.requireValue) {
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
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Summary(),
                    Gap.v(12),
                    Divider(),
                    Expanded(
                      child: _CartItemsList(),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: KitButton(
                label: 'Confirm',
                isLoading: confirmationState is AsyncLoading,
                onPressed: ref.read(confirmationProvider.notifier).confirm,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Summary extends ConsumerWidget {
  const _Summary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.read(cartProvider);
    final orderDetailsState = ref.read(orderDetailsProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SummaryItem(
            title: 'Recipient name',
            text: '${orderDetailsState!.name} ${orderDetailsState.surname}',
          ),
          _SummaryItem(
            title: 'Delivery address',
            text: orderDetailsState.address,
          ),
          _SummaryItem(
            title: 'Sum to pay',
            text: '${cartState.cart.totalSum}\$',
          ),
        ].separate(const Gap.v(8)).toList(),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({super.key, required this.title, required this.text});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return RichText(
      text: TextSpan(
        style: textTheme.bodyLarge,
        children: [
          TextSpan(
            text: '$title: ',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          TextSpan(text: text),
        ],
      ),
    );
  }
}

class _CartItemsList extends ConsumerStatefulWidget {
  const _CartItemsList({super.key});

  @override
  ConsumerState<_CartItemsList> createState() => _CartItemsListState();
}

class _CartItemsListState extends ConsumerState<_CartItemsList> {
  late final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartPositions = ref.read(cartProvider).cart.positions;

    return FadingEdgeScrollView(
      scrollController: _scrollController,
      startEdge: StartFadingEdge(
        color: Theme.of(context).colorScheme.background,
        size: 32,
        offset: 0.3,
      ),
      endEdge: EndFadingEdge(
        color: Theme.of(context).colorScheme.background,
        size: 32,
        offset: 0.3,
      ),
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: cartPositions.length,
        itemBuilder: (BuildContext context, int index) => _CartItem(
          product: cartPositions.keys.elementAt(index),
          count: cartPositions.values.elementAt(index),
        ),
        separatorBuilder: (BuildContext context, int index) => const Gap.v(12),
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  const _CartItem({super.key, required this.product, required this.count});

  final Product product;
  final int count;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
        );

    final countPainter = TextPainter(
      text: TextSpan(
        text: 999.toString(),
        style: textStyle,
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();

    return Row(
      children: [
        const Gap.h(8),
        Container(
          alignment: Alignment.center,
          width: countPainter.width,
          child: Text(
            count.toString(),
            style: textStyle,
          ),
        ),
        const Gap.h(8),
        Text(
          '×',
          style: textStyle,
        ),
        const Gap.h(16),
        Expanded(
          child: _CartItemCard(product: product),
        ),
      ],
    );
  }
}

class _CartItemCard extends StatelessWidget {
  const _CartItemCard({
    required this.product,
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.sizeOf(context).width * 0.15;

    return Card(
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(12),
            ),
            child: CachedNetworkImage(
              imageUrl: product.thumbnailUrl,
              fit: BoxFit.cover,
              height: imageSize,
              width: imageSize,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                product.title,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
              ),
            ),
          ),
        ],
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
