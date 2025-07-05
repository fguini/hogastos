import 'package:flutter/material.dart';

class DialogContainer extends StatelessWidget {
  final Widget child;

  const DialogContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Flexible(
            child: child,
          ),
        )
      )
    );
  }
}
