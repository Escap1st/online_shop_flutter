import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/routing/routes.dart';
import '../../../../shared/presentation/widgets/gap.dart';
import '../../../cart/presentation/cart/providers/cart/cart_provider.dart';
import '../../domain/entities/product.dart';
import 'providers/product_list/product_list_provider.dart';

class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productListState = ref.watch(productListProvider);

    final child = switch (productListState) {
      ProductListLoading() => const Center(child: CircularProgressIndicator()),
      ProductListLoaded(:final response) => ListView.separated(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 16,
          ),
          itemCount: response.items.length,
          itemBuilder: (context, index) {
            final item = response.items[index];
            return _CatalogItemCard(
              key: ValueKey('product_card_${item.id}'),
              product: item,
              onTap: () => ProductDetailsRoute(productId: item.id, $extra: item).go(context),
            );
          },
          separatorBuilder: (context, index) => const Gap.v(12),
        ),
      _ => const SizedBox.shrink(),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_alt_rounded),
          ),
          SizedBox.square(
            // TODO: shouldn't be 'magic' number
            dimension: 56,
            child: Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_cart),
                ),
                const Align(
                  alignment: Alignment.topRight,
                  child: _CartPositionsIndicator(),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(child: child),
    );
  }
}

class _CatalogItemCard extends StatelessWidget {
  const _CatalogItemCard({super.key, required this.product, required this.onTap});

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageSize = MediaQuery.sizeOf(context).width * 0.25;
    final originalPrice = product.price / (100 - product.discountPercentage) * 100;
    final numberFormat = NumberFormat('###.##');

    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        onTap: onTap,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(12),
              ),
              child: Hero(
                tag: 'product_thumbnail_${product.id}',
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: product.thumbnailUrl,
                  height: imageSize,
                  width: imageSize,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: theme.textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap.v(8),
                    Row(
                      children: [
                        if (product.price != originalPrice) ...[
                          Text(
                            '${numberFormat.format(originalPrice)} \$',
                            style: TextStyle(
                              color: theme.colorScheme.error,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const Gap.h(8),
                        ],
                        Text(
                          '${numberFormat.format(product.price)} \$',
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartPositionsIndicator extends ConsumerWidget {
  const _CartPositionsIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final positionsInCart = ref.watch(cartProvider).cart.items.length;

    return positionsInCart > 0
        ? Container(
            margin: const EdgeInsets.all(4),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error,
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            height: 16,
            width: 16,
            child: Text(
              positionsInCart.toString(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onError,
                  ),
            ),
          )
        : const SizedBox.shrink();
  }
}
