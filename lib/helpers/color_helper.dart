import 'package:flutter/material.dart';

Color getTextColor(Color backgroundColor) =>
  backgroundColor.computeLuminance() > 0.5
    ? Colors.black87
    : Colors.white70;

String getColorStringSignature(Color color) => [
  color.a,
  color.b,
  color.g,
  color.r,
  color.colorSpace.name
].join('-');

extension HexColor on Color {
  String toHex({bool leadingHashSign = true}) {
    final hexA = (a * 255).round().toRadixString(16).padLeft(2, '0');
    final hexR = (r * 255).round().toRadixString(16).padLeft(2, '0');
    final hexG = (g * 255).round().toRadixString(16).padLeft(2, '0');
    final hexB = (b * 255).round().toRadixString(16).padLeft(2, '0');

    return '${leadingHashSign ? '#' : ''}$hexA$hexR$hexG$hexB';
  }
}