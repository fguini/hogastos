import 'package:flutter/material.dart';
import 'package:hogastos/components/common/rounded_autocomplete/rounded_autocomplete.dart';
import 'package:hogastos/helpers/form_validator_helper.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/services/movement_service.dart';

const int _movementTextMaxLength = 100;

class MovementTextSuggestion extends StatefulWidget {
  final String? initialValue;
  final bool isLoading;
  final void Function(String?) onTextChanged;

  const MovementTextSuggestion({
    super.key,
    this.initialValue,
    required this.isLoading,
    required this.onTextChanged,
  });

  @override
  State<MovementTextSuggestion> createState() => _MovementTextSuggestionState();
}

class _MovementTextSuggestionState extends State<MovementTextSuggestion> {
  String? selectedText;

  @override
  void initState() {
    if(widget.initialValue != null) {
      setState(() {
        selectedText = widget.initialValue;
      });
    }

    super.initState();
  }

  String _displayStringForOption(String? text) => text ?? '';

  Widget _displayWidgetForOption(String? category) =>
    Text(_displayStringForOption(category));

  Future<List<String>> _buildOptions(TextEditingValue textEditingValue) {
    return MovementService().getMovementSuggestions(
      textEditingValue.text
    );
  }

  void _handleTextChange(String? newText) {
    setState(() {
      selectedText = newText;
    });

    widget.onTextChanged(newText);
  }

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);

    return RoundedAutocomplete<String>(
      initialValue: widget.initialValue,
      displayStringForOption: _displayStringForOption,
      displayWidgetForOption: _displayWidgetForOption,
      optionBuilder: _buildOptions,
      label: localization.movementText,
      isLoading: widget.isLoading,
      validator: FormValidatorHelper
        .of(context)
        .isRequired()
        .maxLength(_movementTextMaxLength)
        .validator,
      onInputChanged: _handleTextChange,
      onValueChanged: _handleTextChange,
    );
  }
}
