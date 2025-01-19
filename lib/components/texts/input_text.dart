import 'package:flutter/material.dart';

import 'base_text.dart';

class InputText extends StatelessWidget {
  final String text;
  final bool enabled;

  const InputText(this.text, {super.key, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return BaseText(
      text,
      fontSize: 18,
      color: enabled ? Colors.black54 : Colors.black26,
    );
  }
}
