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
    TextEditingController? customTextEditingController,
    void Function(String?)? onChanged,
    String? Function(String?)? validator,
  }
) => (
  BuildContext context,
  TextEditingController textEditingController,
  FocusNode focusNode,
  VoidCallback onFieldSubmitted,
) {
  return TextFormField(
    enabled: !isLoading,
    controller: customTextEditingController ?? textEditingController,
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
};