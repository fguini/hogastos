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
      this.color = Colors.black87,
    }
  );

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}
