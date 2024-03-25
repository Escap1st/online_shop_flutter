import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/presentation/widgets/gap.dart';
import '../../../../shared/presentation/widgets/measure_size_widget.dart';
import '../../../../shared/presentation/widgets/screen_error_widget.dart';
import '../../../../shared/presentation/widgets/screen_loading_widget.dart';
import '../../../cart/presentation/cart/providers/cart/cart_provider.dart';
import '../../domain/entities/product.dart';
import 'providers/product_details_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({required this.productId, super.key, this.product});

  final int productId;
  final Product? product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: product != null
            ? _Loaded(product: product!)
            : Consumer(
                builder: (context, ref, child) {
                  final productState = ref.watch(
                    productDetailsProvider(productId),
                  );

                  return switch (productState) {
                    AsyncData(:final value) => _Loaded(product: value),
                    AsyncLoading() => const ScreenLoadingWidget(),
                    AsyncError(:final error, :final stackTrace) => ScreenErrorWidget(
                        exception: error,
                        stackTrace: stackTrace,
                      ),
                    _ => const SizedBox.shrink(),
                  };
                },
              ),
      ),
    );
  }
}

class _Loaded extends StatefulWidget {
  const _Loaded({
    required this.product,
    super.key,
  });

  final Product product;

  @override
  State<_Loaded> createState() => _LoadedState();
}

class _LoadedState extends State<_Loaded> {
  var _footerHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        ListView(
          padding: EdgeInsets.only(bottom: _footerHeight),
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 3,
              child: Hero(
                tag: 'product_thumbnail_${widget.product.id}',
                child: CachedNetworkImage(
                  imageUrl: widget.product.thumbnailUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.title,
                    style: textTheme.headlineMedium,
                  ),
                  const Gap.v(4),
                  Text(
                    'Brand: ${widget.product.brand}',
                    style: textTheme.bodySmall,
                  ),
                  const Gap.v(4),
                  Text(
                    'Category: ${widget.product.category}',
                    style: textTheme.bodySmall,
                  ),
                  const Gap.v(16),
                  const Gap.v(16),
                  Text(widget.product.description),
                ],
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: MeasureSizeWidget(
            onChange: (size) => setState(() => _footerHeight = size.height),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _Footer(product: widget.product),
            ),
          ),
        )
      ],
    );
  }
}

class _Footer extends ConsumerWidget {
  const _Footer({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsInCart = ref.watch(cartProvider).cart.items[product] ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (itemsInCart == 0)
          ElevatedButton(
            onPressed: () => ref.read(cartProvider.notifier).addItem(product: product),
            child: Text('Buy for ${product.price}\$'),
          )
        else
          Row(
            children: [
              ElevatedButton(
                onPressed: () => ref.read(cartProvider.notifier).removeItem(product: product),
                child: const Icon(Icons.remove),
              ),
              const Spacer(),
              Text(
                itemsInCart.toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: itemsInCart < product.stock
                    ? () => ref.read(cartProvider.notifier).addItem(product: product)
                    : null,
                child: const Icon(Icons.add),
              ),
            ],
          ),
        const Gap.v(4),
        Text(
          '${product.stock - itemsInCart} items left',
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        const Gap.v(16),
      ],
    );
  }
}
