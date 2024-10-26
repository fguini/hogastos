import 'package:flutter/material.dart';

import 'base_text.dart';

class TitleText extends StatelessWidget {
  final String text;

  const TitleText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return BaseText(
      text,
      fontSize: 24,
    );
  }
}
