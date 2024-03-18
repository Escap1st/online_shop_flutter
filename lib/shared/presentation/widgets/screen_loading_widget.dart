import 'package:flutter/material.dart';

class ScreenLoadingWidget extends StatelessWidget {
  const ScreenLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
