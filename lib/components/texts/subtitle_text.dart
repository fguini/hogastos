import 'package:flutter/material.dart';
import 'base_text.dart';

class SubtitleText extends StatelessWidget {
  final String text;

  const SubtitleText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return BaseText(
      text,
      fontSize: 20,
    );
  }
}
