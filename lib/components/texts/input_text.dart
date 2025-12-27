import 'package:flutter/material.dart';

import 'base_text.dart';

class InputText extends StatelessWidget {
  final String text;
  final bool enabled;

  const InputText(this.text, {super.key, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var textColor = enabled ? Colors.black54 : Colors.black26;
    if (theme.textTheme.bodyMedium != null) {
      textColor = theme.textTheme.bodyMedium!.color!.withAlpha(
        enabled
          ? 100
          : 60
      );
    }

    return BaseText(
      text,
      fontSize: 18,
      color: textColor,
    );
  }
}
