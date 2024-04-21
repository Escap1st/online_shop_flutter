import 'package:flutter/material.dart';

import '../widgets/gap.dart';

class ErrorDetailsScreen extends StatelessWidget {
  const ErrorDetailsScreen({
    super.key,
    required this.error,
    this.stackTrace,
  });

  final Object error;
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Gap.v(16),
              if (stackTrace != null) Text(stackTrace.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
