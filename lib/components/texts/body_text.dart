import 'package:flutter/material.dart';

import 'base_text.dart';

class BodyText extends StatelessWidget {
  final String text;
  final Color color;

  const BodyText(this.text, {super.key, this.color = Colors.black87});

  @override
  Widget build(BuildContext context) {
    return BaseText(
      text,
      color: color,
      fontSize: 16,
    );
  }
}
