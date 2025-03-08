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