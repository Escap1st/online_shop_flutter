import 'package:flutter/material.dart';

class KitButton extends StatelessWidget {
  const KitButton({
    required this.label,
    required this.onPressed,
    this.style = KitButtonStyle.positive,
    this.isLoading = false,
    super.key,
  });

  final KitButtonStyle style;
  final String label;
  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: style == KitButtonStyle.negative
            ? MaterialStateColor.resolveWith(
                (states) => colorScheme.errorContainer,
              )
            : null,
        foregroundColor: style == KitButtonStyle.negative
            ? MaterialStateColor.resolveWith(
                (states) => colorScheme.error,
              )
            : null,
      ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox.square(
              dimension: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(label),
    );
  }
}

enum KitButtonStyle {
  positive,
  negative,
}
