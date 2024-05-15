import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/routing/routes.dart';
import '../../../../shared/presentation/widgets/fading_edge_scroll_view.dart';
import '../../../../shared/presentation/widgets/gap.dart';
import '../../../../shared/presentation/widgets/kit_button.dart';
import '../../../../shared/presentation/widgets/screen_error_widget.dart';
import '../../../../shared/presentation/widgets/screen_loading_widget.dart';
import '../../../catalog/domain/entities/product.dart';
import '../../domain/entities/cart.dart';
import 'providers/cart/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: switch (cartState) {
        CartLoading() => const ScreenLoadingWidget(),
        CartLoaded(:final cart) => _Loaded(cart: cart),
        CartFailed(:final exception, :final stackTrace) => ScreenErrorWidget(
            error: exception,
            stackTrace: stackTrace,
          ),
      },
    );
  }
}

class _Loaded extends StatelessWidget {
  const _Loaded({required this.cart, super.key});

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return cart.positions.isNotEmpty
        ? _LoadedNonEmpty(cart: cart)
        : Center(
            child: Text(
              'Cart is empty.\nPlease, go to the catalog and add items to perform purchase',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          );
  }
}

class _LoadedNonEmpty extends StatefulWidget {
  const _LoadedNonEmpty({required this.cart, super.key});

  final Cart cart;

  @override
  State<_LoadedNonEmpty> createState() => _LoadedNonEmptyState();
}

class _LoadedNonEmptyState extends State<_LoadedNonEmpty> {
  late final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          children: [
            const Gap.v(16),
            _TotalSection(title: 'Positions', value: widget.cart.positions.length.toString()),
            const Gap.v(12),
            _TotalSection(title: 'Items', value: widget.cart.items.toString()),
            const Gap.v(12),
            _TotalSection(title: 'Total sum', value: '${widget.cart.totalSum}\$'),
            const Gap.v(12),
            const Divider(indent: 8, endIndent: 8),
          ],
        ),
        Expanded(
          child: FadingEdgeScrollView(
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
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16,
              ),
              itemCount: widget.cart.positions.length,
              itemBuilder: (context, index) => _CartItemCard(
                product: widget.cart.positions.keys.elementAt(index),
                count: widget.cart.positions.values.elementAt(index),
              ),
              separatorBuilder: (context, index) => const Gap.v(12),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: KitButton(
            label: 'Place an order',
            onPressed: () => const OrderDetailsRoute().go(context),
          ),
        ),
      ],
    );
  }
}

class _TotalSection extends StatelessWidget {
  const _TotalSection({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyLarge;

    TextPainter painter(String text) => TextPainter(
          text: TextSpan(text: text, style: style),
          maxLines: 1,
          textDirection: TextDirection.ltr,
        )..layout();

    final titlePainter = painter(title);
    final valuePainter = painter(value);
    final availableWidth = MediaQuery.of(context).size.width -
        16 * 2 -
        8 * 2 -
        valuePainter.width -
        titlePainter.width;

    var separatorPainter = painter(' ');

    while (separatorPainter.width < availableWidth) {
      separatorPainter = painter('${separatorPainter.plainText}. ');
    }

    return Row(
      children: [
        const Gap.h(16),
        Text(title, textWidthBasis: TextWidthBasis.longestLine, style: style),
        const Gap.h(8),
        Expanded(
          child: Text(
            separatorPainter.plainText.trim(),
            style: style,
            textAlign: TextAlign.center,
          ),
        ),
        const Gap.h(8),
        Text(value, style: style),
        const Gap.h(16),
      ],
    );
  }
}

class _CartItemCard extends ConsumerWidget {
  const _CartItemCard({
    required this.product,
    required this.count,
    super.key,
  });

  final Product product;
  final int count;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageSize = MediaQuery.sizeOf(context).width * 0.2;

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
                maxLines: 2,
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => ref.read(cartProvider.notifier).removeItem(product: product),
                    icon: const Icon(Icons.remove),
                    iconSize: 20,
                  ),
                  Text(
                    count.toString(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  IconButton(
                    onPressed: count < product.stock
                        ? () => ref.read(cartProvider.notifier).addItem(product: product)
                        : null,
                    icon: const Icon(Icons.add),
                    iconSize: 20,
                  ),
                ],
              ),
              Text(
                '${product.stock - count} left',
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        ],
      ),
    );
  }
}
