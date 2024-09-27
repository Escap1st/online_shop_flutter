import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/iterable.dart';
import '../../../../shared/presentation/widgets/gap.dart';
import '../../../../shared/presentation/widgets/kit_button.dart';
import '../../../../shared/presentation/widgets/screen_error_widget.dart';
import '../../../../shared/presentation/widgets/screen_loading_widget.dart';
import '../../domain/entities/product_review.dart';
import '../../domain/entities/product_review_comment.dart';
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Reviews'),
            if (productName != null)
              Text(
                productName!,
                style: Theme.of(context).textTheme.titleSmall,
              ),
          ],
        ),
      ),
      body: switch (reviewsState) {
        AsyncData(:final value) => _Loaded(value),
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

class _Loaded extends StatefulWidget {
  const _Loaded(this.reviews, {super.key});

  final List<ProductReview> reviews;

  @override
  State<_Loaded> createState() => _LoadedState();
}

class _LoadedState extends State<_Loaded> {
  final List<String> _expandedItems = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    if (widget.reviews.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'There are no reviews yet',
            style: textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ExpansionPanelList(
            children: widget.reviews
                .map(
                  (e) => ExpansionPanel(
                    isExpanded: _expandedItems.contains(e.id),
                    headerBuilder: (context, expanded) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipOval(
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 48,
                                    width: 48,
                                    color: theme.colorScheme.secondaryContainer,
                                    child: Text(
                                      e.user.username[0].toUpperCase(),
                                      style: textTheme.headlineMedium,
                                    ),
                                  ),
                                ),
                                const Gap.h(16),
                                Expanded(
                                  child: Text(
                                    e.title,
                                    style: textTheme.titleMedium,
                                  ),
                                ),
                              ],
                            ),
                            const Gap.v(16),
                            Text(
                              e.body,
                              style: textTheme.bodyLarge,
                            ),
                            const Gap.v(16),
                            Row(
                              children: e.photos
                                  .take(3)
                                  .map<Widget>(
                                    (photo) => Expanded(
                                      child: CachedNetworkImage(imageUrl: photo.thumbnailUrl),
                                    ),
                                  )
                                  .separate(const Gap.h(8))
                                  .toList(),
                            )
                          ],
                        ),
                      );
                    },
                    body: _Comments(e.comments),
                  ),
                )
                .toList(),
            expansionCallback: (index, isExpanded) {
              final id = widget.reviews[index].id;
              setState(() => isExpanded ? _expandedItems.add(id) : _expandedItems.remove(id));
            },
            expandedHeaderPadding: EdgeInsets.zero,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: KitButton(
              label: 'Add review',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => _EditReviewDialog(
                    onSubmit: (title, body) {
                      Navigator.of(context).pop();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Comments extends StatelessWidget {
  const _Comments(this.comments, {super.key});

  final List<ProductReviewComment> comments;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...comments
            .map(
              (e) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 48, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap.v(8),
                        Text(
                          e.name,
                          style: textTheme.titleMedium,
                        ),
                        const Gap.v(8),
                        Text(
                          e.body,
                          style: textTheme.bodyLarge,
                        ),
                        const Gap.v(8),
                      ],
                    ),
                  ),
                ],
              ),
            )
            .toList(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: KitButton(
            label: 'Add comment',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => _EditCommentDialog(
                  onSubmit: (body) {
                    Navigator.of(context).pop();
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _EditReviewDialog extends StatefulWidget {
  const _EditReviewDialog({required this.onSubmit, super.key});

  final void Function(String, String) onSubmit;

  @override
  State<_EditReviewDialog> createState() => _EditReviewDialogState();
}

class _EditReviewDialogState extends State<_EditReviewDialog> {
  late final _titleController = TextEditingController();
  late final _bodyController = TextEditingController();
  late final _bodyFocus = FocusNode();

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _bodyFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(24),
      content: SizedBox(
        width: MediaQuery.sizeOf(context).width - 48,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              autofocus: true,
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Enter title'),
              onFieldSubmitted: (_) => _bodyFocus.requestFocus(),
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
              controller: _bodyController,
              focusNode: _bodyFocus,
              decoration: const InputDecoration(labelText: 'Enter details'),
            ),
          ],
        ),
      ),
      actions: [
        KitButton(
          label: 'Cancel',
          onPressed: Navigator.of(context).pop,
        ),
        KitButton(
          label: 'Submit',
          onPressed: () => widget.onSubmit(_titleController.text, _bodyController.text),
        ),
      ],
    );
  }
}

class _EditCommentDialog extends StatefulWidget {
  const _EditCommentDialog({required this.onSubmit, super.key});

  final void Function(String) onSubmit;

  @override
  State<_EditCommentDialog> createState() => _EditCommentDialogState();
}

class _EditCommentDialogState extends State<_EditCommentDialog> {
  late final _bodyController = TextEditingController();

  @override
  void dispose() {
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(24),
      content: SizedBox(
        width: MediaQuery.sizeOf(context).width - 48,
        child: TextFormField(
          autofocus: true,
          controller: _bodyController,
          decoration: const InputDecoration(labelText: 'Enter comment'),
        ),
      ),
      actions: [
        KitButton(
          label: 'Cancel',
          onPressed: Navigator.of(context).pop,
        ),
        KitButton(
          label: 'Submit',
          onPressed: () => widget.onSubmit(_bodyController.text),
        ),
      ],
    );
  }
}
