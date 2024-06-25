import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/iterable.dart';
import '../../../feature/catalog/domain/entities/product.dart';
import '../../../feature/order/domain/entities/order.dart';
import 'fading_edge_scroll_view.dart';
import 'gap.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    required this.order,
    required this.products,
    this.shrinkWrap = false,
    super.key,
  });

  final Order order;
  final List<Product> products;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Header(
          order: order,
        ),
        const Gap.v(12),
        const Divider(),
        Expanded(
          flex: shrinkWrap ? 0 : 1,
          child: _OrderPositionsList(
            positions: order.entries.asMap().map(
                  (_, e) => MapEntry(
                    products.singleWhere((p) => p.id == e.productId),
                    e.count,
                  ),
                ),
            shrinkWrap: shrinkWrap,
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.order, super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _HeaderItem(
            title: 'Recipient name',
            text: '${order.details.name} ${order.details.surname}',
          ),
          _HeaderItem(
            title: 'Delivery address',
            text: order.details.address,
          ),
          _HeaderItem(
            title: 'Sum to pay',
            text: '${order.totalSum.toStringAsFixed(2)}\$',
          ),
        ].separate(const Gap.v(8)).toList(),
      ),
    );
  }
}

class _HeaderItem extends StatelessWidget {
  const _HeaderItem({super.key, required this.title, required this.text});

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

class _OrderPositionsList extends StatefulWidget {
  const _OrderPositionsList({
    required this.positions,
    super.key,
    this.shrinkWrap = false,
  });

  final Map<Product, int> positions;
  final bool shrinkWrap;

  @override
  State<_OrderPositionsList> createState() => _OrderPositionsListState();
}

class _OrderPositionsListState extends State<_OrderPositionsList> {
  late final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = ListView.separated(
      controller: _scrollController,
      shrinkWrap: widget.shrinkWrap,
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: widget.positions.length,
      itemBuilder: (BuildContext context, int index) => _OrderPosition(
        product: widget.positions.keys.elementAt(index),
        count: widget.positions.values.elementAt(index),
      ),
      separatorBuilder: (BuildContext context, int index) => const Gap.v(12),
    );

    return widget.shrinkWrap
        ? list
        : FadingEdgeScrollView(
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
            child: list,
          );
  }
}

class _OrderPosition extends StatelessWidget {
  const _OrderPosition({super.key, required this.product, required this.count});

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
          child: _ProductCard(product: product),
        ),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
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
