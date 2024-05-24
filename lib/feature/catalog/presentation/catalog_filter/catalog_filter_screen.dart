import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/iterable.dart';
import '../../../../shared/presentation/widgets/gap.dart';
import '../../../../shared/presentation/widgets/screen_error_widget.dart';
import '../../../../shared/presentation/widgets/screen_loading_widget.dart';
import '../../domain/entities/product_category.dart';
import 'providers/catalog_filter_provider/catalog_filter_provider.dart';
import 'providers/catalog_filters_data_provider/catalog_filters_data_provider.dart';

class CatalogFilterScreen extends ConsumerStatefulWidget {
  const CatalogFilterScreen({super.key});

  @override
  ConsumerState<CatalogFilterScreen> createState() => _CatalogFilterScreenState();
}

class _CatalogFilterScreenState extends ConsumerState<CatalogFilterScreen> {
  @override
  void initState() {
    if (ref.read(catalogFiltersDataProvider).hasError) {
      ref.read(catalogFiltersDataProvider.notifier).invalidate();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final catalogFiltersDataState = ref.watch(catalogFiltersDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: SafeArea(
        child: switch (catalogFiltersDataState) {
          AsyncData(:final value) => _Loaded(catalogFiltersDataState: value),
          AsyncLoading() => const ScreenLoadingWidget(),
          AsyncError(:final error, :final stackTrace) => ScreenErrorWidget(
              error: error,
              stackTrace: stackTrace,
              onRetry: () => ref.read(catalogFiltersDataProvider.notifier).invalidate(),
              isRetrying: catalogFiltersDataState.isRefreshing,
            ),
          _ => const SizedBox.shrink(),
        },
      ),
    );
  }
}

class _Loaded extends ConsumerWidget {
  const _Loaded({super.key, required this.catalogFiltersDataState});

  final CatalogFiltersDataState catalogFiltersDataState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogFilterState = ref.watch(catalogFilterProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _Section(
          title: 'Categories',
          child: _Categories(
            allItems: catalogFiltersDataState.categories,
            selectedItems: catalogFilterState.selectedCategories,
            onItemToggled: (item) => ref.read(catalogFilterProvider.notifier).toggleCategory(item),
          ),
        )
      ].separate(const Gap.v(16)).toList(),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Gap.v(8),
        child,
      ],
    );
  }
}

class _Categories extends StatelessWidget {
  const _Categories({
    required this.allItems,
    required this.selectedItems,
    required this.onItemToggled,
    super.key,
  });

  final List<ProductCategory> allItems;
  final List<ProductCategory> selectedItems;
  final void Function(ProductCategory) onItemToggled;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Wrap(
      spacing: 8,
      children: allItems
          .map(
            (e) => ActionChip(
              label: Text(e.name),
              backgroundColor: selectedItems.contains(e) ? colorScheme.primary : null,
              labelStyle: TextStyle(
                color: selectedItems.contains(e) ? colorScheme.onPrimary : null,
              ),
              labelPadding: EdgeInsets.zero,
              onPressed: () => onItemToggled(e),
            ),
          )
          .toList(),
    );
  }
}
