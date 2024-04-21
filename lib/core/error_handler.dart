import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../shared/presentation/screens/error_details_screen.dart';
import '../shared/presentation/widgets/screen_error_widget.dart';

// TODO: consider about displaying loading state for fullscreen states properly
abstract class IErrorHandler {
  void showNotification(
    BuildContext context, {
    required Object error,
    required StackTrace? stackTrace,
  });

  Future<void> showFullscreenDialog(
    BuildContext context, {
    required Object error,
    required StackTrace? stackTrace,
    VoidCallback? onRetry,
  });

  Widget buildFullscreenWidget(
    BuildContext context, {
    required Object error,
    required StackTrace? stackTrace,
    VoidCallback? onRetry,
  });
}

class ErrorHandler implements IErrorHandler {
  @override
  Widget buildFullscreenWidget(
    BuildContext context, {
    required Object error,
    required StackTrace? stackTrace,
    VoidCallback? onRetry,
  }) {
    return ScreenErrorWidget(
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  Future<void> showFullscreenDialog(
    BuildContext context, {
    required Object error,
    required StackTrace? stackTrace,
    VoidCallback? onRetry,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          body: SafeArea(
            child: buildFullscreenWidget(
              context,
              error: error,
              stackTrace: stackTrace,
            ),
          ),
        );
      },
    );
  }

  @override
  void showNotification(
    BuildContext context, {
    required Object error,
    required StackTrace? stackTrace,
  }) {
    final snackBar = SnackBar(
      content: Text(error.toString()),
      action: kDebugMode
          ? SnackBarAction(
              label: 'Details',
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ErrorDetailsScreen(
                    error: error,
                    stackTrace: stackTrace,
                  ),
                ),
              ),
            )
          : null,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
