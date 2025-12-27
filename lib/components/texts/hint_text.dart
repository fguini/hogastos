import 'package:flutter/material.dart';

import 'base_text.dart';

class HintText extends StatelessWidget {
  final String text;
  final Color? color;

  const HintText(this.text, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textColor = color ?? theme.textTheme.labelMedium?.color ?? Colors.black54;

    return BaseText(
      text,
      color: textColor,
      fontSize: 14,
    );
  }
}
