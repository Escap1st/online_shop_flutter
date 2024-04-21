import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../screens/error_details_screen.dart';
import 'gap.dart';

class ScreenErrorWidget extends StatelessWidget {
  const ScreenErrorWidget({
    required this.error,
    this.stackTrace,
    this.onRetry,
    this.isRetrying = false,
    super.key,
  });

  final Object error;
  final StackTrace? stackTrace;
  final VoidCallback? onRetry;
  final bool isRetrying;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              error.toString(),
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const Gap.v(16),
              FractionallySizedBox(
                widthFactor: 0.33,
                child: ElevatedButton(
                  onPressed: onRetry,
                  child: isRetrying
                      ? const SizedBox.square(
                          dimension: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Retry'),
                ),
              ),
            ],
            if (kDebugMode) ...[
              const Gap.v(8),
              FractionallySizedBox(
                widthFactor: 0.33,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ErrorDetailsScreen(
                        error: error,
                        stackTrace: stackTrace,
                      ),
                    ),
                  ),
                  child: const Text('Details'),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
