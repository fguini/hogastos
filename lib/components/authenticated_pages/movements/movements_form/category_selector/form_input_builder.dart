import 'package:flutter/material.dart';
import 'package:hogastos/configurations/routes.dart';
import 'package:hogastos/helpers/form_validator_helper.dart';
import 'package:hogastos/helpers/navigator_helper.dart';

typedef FormInputBuilder = Widget Function(
  BuildContext context,
  TextEditingController textEditingController,
  FocusNode focusNode,
  VoidCallback onFieldSubmitted,
);

FormInputBuilder formInputBuilder(String label) => (
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
    suffixIcon: IconButton(
      icon: Icon(Icons.add),
      onPressed: () =>
        NavigatorHelper.pushNamed(
          context,
          RoutesNames.categoriesCreate,
          arguments: 'createMovement',
        ),
    ),
  ),
  validator: FormValidatorHelper.of(context).isRequired().validator,
);