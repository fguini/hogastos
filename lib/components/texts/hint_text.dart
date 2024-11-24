import 'package:flutter/material.dart';

import 'base_text.dart';

class HintText extends StatelessWidget {
  final String text;
  final Color? color;

  const HintText(this.text, {super.key, this.color = Colors.black54});

  @override
  Widget build(BuildContext context) {
    return BaseText(
      text,
      color: color,
      fontSize: 14,
    );
  }
}
