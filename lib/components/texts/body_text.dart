import 'package:flutter/material.dart';

import 'base_text.dart';

class BodyText extends StatelessWidget {
  final String text;
  final Color? color;

  const BodyText(this.text, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textColor = color ?? theme.textTheme.bodyMedium?.color ?? Colors.black87;

    return BaseText(
      text,
      color: textColor,
      fontSize: 16,
    );
  }
}
