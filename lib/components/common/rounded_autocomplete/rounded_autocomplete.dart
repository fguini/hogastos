import 'dart:async';

import 'package:flutter/material.dart';

import 'form_input_builder.dart';
import 'options_view_builder.dart';

typedef DisplayStringForOption<T> = String Function(T?);
typedef DisplayWidgetForOption<T> = Widget Function(T?);
typedef OptionBuilder<T> = FutureOr<Iterable<T>> Function(TextEditingValue);
typedef BuildInputInputIcon<T> = Widget? Function(T?);
typedef Validator = String? Function(String?);
typedef HandleInputChanged = void Function(String?);
typedef HandleValueChanged<T> = void Function(T?);

class RoundedAutocomplete<T extends Object> extends StatelessWidget {
  final T? initialValue;
  final DisplayStringForOption<T> displayStringForOption;
  final DisplayWidgetForOption<T> displayWidgetForOption;
  final OptionBuilder<T> optionBuilder;
  final String label;
  final bool isLoading;
  final T? selectedValue;
  final BuildInputInputIcon<T>? inputPrefixIconBuilder;
  final BuildInputInputIcon<T>? inputSuffixIconBuilder;
  final TextEditingController? textEditingController;
  final Validator validator;
  final HandleInputChanged? onInputChanged;
  final HandleValueChanged<T> onValueChanged;

  const RoundedAutocomplete({
    super.key,
    this.initialValue,
    required this.displayStringForOption,
    required this.displayWidgetForOption,
    required this.optionBuilder,
    required this.label,
    this.isLoading = false,
    this.selectedValue,
    this.inputPrefixIconBuilder,
    this.inputSuffixIconBuilder,
    this.textEditingController,
    required this.validator,
    this.onInputChanged,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<T>(
      initialValue: initialValue == null
        ? null
        : TextEditingValue(text: displayStringForOption(initialValue)),
      displayStringForOption: displayStringForOption,
      optionsBuilder: optionBuilder,
      optionsViewBuilder: optionsViewBuilder(
        displayWidgetForOption: displayWidgetForOption
      ),
      fieldViewBuilder: formInputBuilder(
        label,
        isLoading: isLoading,
        prefixIcon: inputPrefixIconBuilder == null
          ? null
          : inputPrefixIconBuilder!(selectedValue),
        suffixIcon: inputSuffixIconBuilder == null
          ? null
          : inputSuffixIconBuilder!(selectedValue),
        customTextEditingController: textEditingController,
        onChanged: onInputChanged,
        validator: validator,
      ),
      onSelected: onValueChanged,
    );
  }
}
