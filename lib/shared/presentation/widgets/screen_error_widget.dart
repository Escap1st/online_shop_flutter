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
    return const SizedBox.shrink();
  }
}
