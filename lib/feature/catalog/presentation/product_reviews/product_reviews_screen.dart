import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../shared/presentation/widgets/screen_error_widget.dart';
import '../../../../shared/presentation/widgets/screen_loading_widget.dart';
import 'providers/product_reviews_provider.dart';

class ProductReviewsScreen extends ConsumerWidget {
  const ProductReviewsScreen({super.key, required this.productId, required this.productName});

  final int productId;
  final String? productName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = productReviewsProvider(productId);
    final reviewsState = ref.watch(provider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews${productName?.let((it) => ' - $it') ?? ''}'),
      ),
      body: switch (reviewsState) {
        AsyncData(:final value) => const Placeholder(),
        AsyncLoading() => const ScreenLoadingWidget(),
        AsyncError(:final error, :final stackTrace) => ScreenErrorWidget(
            error: error,
            stackTrace: stackTrace,
            onRetry: () => ref.invalidate(provider),
            isRetrying: reviewsState.isRefreshing,
          ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
