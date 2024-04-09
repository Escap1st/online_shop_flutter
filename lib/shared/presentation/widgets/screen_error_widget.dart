import 'package:flutter/material.dart';

class ScreenErrorWidget extends StatelessWidget {
  const ScreenErrorWidget({
    required this.exception,
    required this.stackTrace,
    super.key,
  });

  final Object exception;
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          exception.toString(),
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
