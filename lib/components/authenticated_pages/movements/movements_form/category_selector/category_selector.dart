import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/home/home_layout.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/services/category_service.dart';

import 'form_input_builder.dart';
import 'options_view_builder.dart';

class CategorySelector extends StatelessWidget {
  final Category? initialValue;
  final void Function(Category category) onCategoryChanged;

  const CategorySelector({
    super.key,
    required this.initialValue,
    required this.onCategoryChanged,
  });

  String _displayStringForOption(Category category) => category.description;

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);

    return Autocomplete<Category>(
      initialValue: initialValue == null
        ? null
        : TextEditingValue(text: initialValue!.description),
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        return CategoryService().getCategoriesByDescription(
          textEditingValue.text
        );
      },
      optionsViewBuilder: optionsViewBuilder(
        displayStringForOption: _displayStringForOption
      ),
      fieldViewBuilder: formInputBuilder(localization.category),
      onSelected: onCategoryChanged,
    );
  }
}
