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

class RoundedAutocomplete<T extends Object> extends StatefulWidget {
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
  State<RoundedAutocomplete<T>> createState() => _RoundedAutocompleteState<T>();
}

class _RoundedAutocompleteState<T extends Object> extends State<RoundedAutocomplete<T>> {
  late FocusNode _node;
  late GlobalKey _globalKey;

  @override
  void initState() {
    _node = FocusNode(debugLabel: 'RoundedAutocomplete');
    _globalKey = GlobalKey();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<T>(
      key: widget.textEditingController == null
        ? null
        : _globalKey,
      initialValue: widget.initialValue == null
        ? null
        : TextEditingValue(text: widget.displayStringForOption(widget.initialValue)),
      displayStringForOption: widget.displayStringForOption,
      optionsBuilder: widget.optionBuilder,
      optionsViewBuilder: optionsViewBuilder(
        displayWidgetForOption: widget.displayWidgetForOption
      ),
      fieldViewBuilder: formInputBuilder(
        widget.label,
        isLoading: widget.isLoading,
        prefixIcon: widget.inputPrefixIconBuilder == null
          ? null
          : widget.inputPrefixIconBuilder!(widget.selectedValue),
        suffixIcon: widget.inputSuffixIconBuilder == null
          ? null
          : widget.inputSuffixIconBuilder!(widget.selectedValue),
        customTextEditingController: widget.textEditingController,
        onChanged: widget.onInputChanged,
        validator: widget.validator,
      ),
      focusNode: widget.textEditingController == null
        ? null
        : _node,
      textEditingController: widget.textEditingController,
      onSelected: widget.onValueChanged,
    );
  }
}
