import 'package:flutter/material.dart';
import 'package:hogastos/configurations/themes.dart';

Color getTextColor(Color backgroundColor) => backgroundColor.computeLuminance() > 0.5
  ? lightTheme.textTheme.bodyMedium?.color ?? Colors.black87
  : darkTheme.textTheme.bodyMedium?.color ?? Colors.white70;

Color getDefaultThemeTextColor(ThemeData theme) => theme.textTheme.bodyMedium?.color
  ?? Colors.black87;

String getColorStringSignature(Color color) => [
  color.a,
  color.b,
  color.g,
  color.r,
  color.colorSpace.name
].join('-');

extension HexColor on Color {
  String toHex({bool leadingHashSign = true}) {
    final hexR = (r * 255).round().toRadixString(16).padLeft(2, '0');
    final hexG = (g * 255).round().toRadixString(16).padLeft(2, '0');
    final hexB = (b * 255).round().toRadixString(16).padLeft(2, '0');

    return '${leadingHashSign ? '#' : ''}$hexR$hexG$hexB';
  }
}