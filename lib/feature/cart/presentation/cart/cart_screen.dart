import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/presentation/widgets/fading_edge_scroll_view.dart';
import '../../../../shared/presentation/widgets/gap.dart';
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
            exception: exception,
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
    return cart.items.isNotEmpty
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
      children: [
        Expanded(
          child: FadingEdgeScrollView(
            scrollController: _scrollController,
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
              itemCount: widget.cart.items.length,
              itemBuilder: (context, index) => _CartItemCard(
                product: widget.cart.items.keys.elementAt(index),
                count: widget.cart.items.values.elementAt(index),
              ),
              separatorBuilder: (context, index) => const Gap.v(12),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Proceed'),
            ),
          ),
        ),
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
