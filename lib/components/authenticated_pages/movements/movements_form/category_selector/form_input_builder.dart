import 'package:flutter/material.dart';

typedef FormInputBuilder = Widget Function(
  BuildContext context,
  TextEditingController textEditingController,
  FocusNode focusNode,
  VoidCallback onFieldSubmitted,
);

FormInputBuilder formInputBuilder(
  String label,
  {
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }
) => (
  BuildContext context,
  TextEditingController textEditingController,
  FocusNode focusNode,
  VoidCallback onFieldSubmitted,
) => TextFormField(
  controller: textEditingController,
  focusNode: focusNode,
  onFieldSubmitted: (String value) => onFieldSubmitted(),
  decoration: InputDecoration(
    label: Text(label),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
  ),
  validator: validator,
);