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
    bool isLoading = false,
    Widget? prefixIcon,
    Widget? suffixIcon,
    void Function(String?)? onChanged,
    String? Function(String?)? validator,
  }
) => (
  BuildContext context,
  TextEditingController textEditingController,
  FocusNode focusNode,
  VoidCallback onFieldSubmitted,
) => TextFormField(
  enabled: !isLoading,
  controller: textEditingController,
  focusNode: focusNode,
  onFieldSubmitted: (String value) => onFieldSubmitted(),
  decoration: InputDecoration(
    label: Text(label),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
  ),
  onChanged: onChanged,
  validator: validator,
);