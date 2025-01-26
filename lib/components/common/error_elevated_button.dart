import 'package:flutter/material.dart';

class ErrorElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;

  const ErrorElevatedButton({
    super.key,
    required this.child,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          theme.colorScheme.errorContainer
        ),
        side: WidgetStateProperty.all(
          BorderSide(color: theme.colorScheme.error),
        ),
      ),
      child: child,
    );
  }
}
