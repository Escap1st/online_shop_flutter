import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/routing/routes.dart';
import '../../../../shared/presentation/widgets/gap.dart';
import '../order_details/providers/order_details_provider.dart';

class OrderConfirmationScreen extends ConsumerWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderDetailsState = ref.read(orderDetailsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order confirmation'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             Expanded(
              child: ListView(
                children: [
                  Text(orderDetailsState!.name),
                ]
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const _Dialog(),
                  );
                },
                child: const Text('Confirm'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Dialog extends StatelessWidget {
  const _Dialog({super.key});

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
              ElevatedButton(
                onPressed: () => const CatalogRoute().go(context),
                child: const Text('Continue shopping'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
