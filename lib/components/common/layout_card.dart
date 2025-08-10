import 'package:flutter/material.dart';

class LayoutCard extends StatelessWidget {
  final Widget child;

  const LayoutCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    const cardPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 10);

    return Card(
      child: Container(
        padding: cardPadding,
        child: child,
      ),
    );
  }
}
