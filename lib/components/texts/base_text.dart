import 'package:flutter/material.dart';

class BaseText extends StatelessWidget {
  final String text;
  final double  fontSize;
  final Color? color;

  const BaseText(
    this.text,
    {
      super.key,
      required this.fontSize,
      this.color,
    }
  );

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textColor = color ?? theme.textTheme.bodyMedium?.color ?? Colors.black87;

    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: textColor,
      ),
    );
  }
}
