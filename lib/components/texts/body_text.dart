import 'package:flutter/material.dart';

import 'base_text.dart';

class BodyText extends StatelessWidget {
  final String text;

  const BodyText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return BaseText(
      text,
      fontSize: 16,
    );
  }
}
