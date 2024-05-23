import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/di/dependencies.dart';
import '../../../../core/error_handler.dart';
import '../../../../core/routing/routes.dart';
import '../../../../shared/presentation/widgets/gap.dart';
import '../../../../shared/presentation/widgets/screen_error_widget.dart';
import '../../../../shared/presentation/widgets/screen_loading_widget.dart';
import '../../../cart/presentation/cart/providers/cart/cart_provider.dart';
import '../../domain/entities/product.dart';
import '../catalog_filter/providers/catalog_filter_provider/catalog_filter_provider.dart';
import 'providers/catalog/catalog_provider.dart';

class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogState = ref.watch(catalogProvider);

    _handlePaginationFailed(context, catalogState);

    final child = switch (catalogState) {
      CatalogLoading() => const ScreenLoadingWidget(),
      CatalogLoaded(:final products, :final isPaginationAvailable) => _Loaded(
          products: products,
          isPaginating: false,
          isPaginationAvailable: isPaginationAvailable,
        ),
      CatalogFailed(:final exception, :final stackTrace, :final isReloading) => ScreenErrorWidget(
          error: exception,
          stackTrace: stackTrace,
          isRetrying: isReloading,
          onRetry: ref.read(catalogProvider.notifier).reload,
        ),
      CatalogPaginating(:final products) => _Loaded(
          products: products,
          isPaginating: true,
          isPaginationAvailable: false,
        ),
      CatalogPaginationFailed(:final products) => _Loaded(
          products: products,
          isPaginating: false,
          isPaginationAvailable: true,
        ),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog'),
        actions: [
          _AppBarAction(
            icon: Icons.filter_alt_rounded,
            indicator: const _SelectedFiltersIndicator(),
            onPressed: () => const CatalogFilterRoute().go(context),
          ),
          _AppBarAction(
            icon: Icons.shopping_cart,
            indicator: const _CartPositionsIndicator(),
            onPressed: () => const CartRoute().push(context),
          ),
        ],
      ),
      body: SafeArea(child: child),
    );
  }

  void _handlePaginationFailed(BuildContext context, CatalogState state) {
    if (state is CatalogPaginationFailed) {
      resolveDependency<ErrorHandler>().showNotification(
        context,
        error: state.exception,
        stackTrace: state.stackTrace,
      );
    }
  }
}

class _AppBarAction extends StatelessWidget {
  const _AppBarAction({
    required this.icon,
    required this.indicator,
    required this.onPressed,
    super.key,
  });

  final IconData icon;
  final Widget? indicator;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      // TODO: shouldn't be 'magic' number
      dimension: 56,
      child: Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            onPressed: onPressed,
            icon: Icon(icon),
          ),
          Align(
            alignment: Alignment.topRight,
            child: indicator,
          ),
        ],
      ),
    );
  }
}

class _Loaded extends StatelessWidget {
  const _Loaded({
    super.key,
    required this.products,
    required this.isPaginating,
    required this.isPaginationAvailable,
  });

  final List<Product> products;
  final bool isPaginating;
  final bool isPaginationAvailable;

  @override
  Widget build(BuildContext context) {
    return products.isNotEmpty
        ? _LoadedNonEmpty(
            products: products,
            isPaginating: isPaginating,
            isPaginationAvailable: isPaginationAvailable,
          )
        : Center(
            child: Text(
              'No items fitting your filters',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          );
  }
}

class _LoadedNonEmpty extends ConsumerStatefulWidget {
  const _LoadedNonEmpty({
    super.key,
    required this.products,
    required this.isPaginating,
    required this.isPaginationAvailable,
  });

  final List<Product> products;
  final bool isPaginating;
  final bool isPaginationAvailable;

  @override
  ConsumerState<_LoadedNonEmpty> createState() => _LoadedNonEmptyState();
}

class _LoadedNonEmptyState extends ConsumerState<_LoadedNonEmpty> {
  late final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (!widget.isPaginationAvailable) {
        return;
      }

      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        final maxScrollExtent = _scrollController.position.maxScrollExtent;
        if (maxScrollExtent != 0 && maxScrollExtent == _scrollController.position.pixels) {
          ref.read(catalogProvider.notifier).getNextPage();

          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 100),
              curve: Curves.linear,
            );
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 16,
      ),
      itemCount: widget.isPaginating ? widget.products.length + 1 : widget.products.length,
      itemBuilder: (context, index) {
        if (index == widget.products.length) {
          return const Center(
            child: SizedBox.square(
              dimension: 32,
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          final item = widget.products[index];
          return _CatalogItemCard(
            key: ValueKey('product_card_${item.id}'),
            product: item,
            onTap: () => ProductDetailsRoute(productId: item.id, $extra: item).go(context),
          );
        }
      },
      separatorBuilder: (context, index) => const Gap.v(12),
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
                            '${numberFormat.format(originalPrice)}\$',
                            style: TextStyle(
                              color: theme.colorScheme.error,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const Gap.h(8),
                        ],
                        Text(
                          '${numberFormat.format(product.price)}\$',
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
    final positionsInCart = ref.watch(cartProvider).cart.positions.length;
    return positionsInCart > 0 ? _Indicator(value: positionsInCart) : const SizedBox.shrink();
  }
}

class _SelectedFiltersIndicator extends ConsumerWidget {
  const _SelectedFiltersIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilters = ref.watch(catalogFilterProvider).activeFilters;
    return selectedFilters > 0 ? _Indicator(value: selectedFilters) : const SizedBox.shrink();
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({required this.value, super.key});

  final int value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.colorScheme.error,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      height: 16,
      width: 16,
      child: Text(
        value.toString(),
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onError,
        ),
      ),
    );
  }
}
