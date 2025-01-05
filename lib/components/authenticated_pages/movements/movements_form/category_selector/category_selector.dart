import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/home/home_layout.dart';
import 'package:hogastos/configurations/routes.dart';
import 'package:hogastos/helpers/form_validator_helper.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/helpers/navigator_helper.dart';
import 'package:hogastos/services/category_service.dart';

import 'form_input_builder.dart';
import 'options_view_builder.dart';

class CategorySelector extends StatefulWidget {
  final Category? initialValue;
  final void Function(Category category) onCategoryChanged;

  const CategorySelector({
    super.key,
    required this.initialValue,
    required this.onCategoryChanged,
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  Category? selectedCategory;

  @override
  void initState() {
    if(widget.initialValue != null) {
      setState(() {
        selectedCategory = widget.initialValue;
      });
    }

    super.initState();
  }

  String _displayStringForOption(Category category) => category.description;

  Widget _displayWidgetForOption(Category category) => Row(
    children: [
      Icon(category.icon, color: category.color),
      SizedBox(width: 4),
      Text(_displayStringForOption(category)),
    ],
  );

  void _handleCategoryChange(Category newCategory) {
    setState(() {
      selectedCategory = newCategory;
    });

    widget.onCategoryChanged(newCategory);
  }

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);

    return Autocomplete<Category>(
      initialValue: widget.initialValue == null
        ? null
        : TextEditingValue(text: widget.initialValue!.description),
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        return CategoryService().getCategoriesByDescription(
          textEditingValue.text
        );
      },
      optionsViewBuilder: optionsViewBuilder(
        displayWidgetForOption: _displayWidgetForOption
      ),
      fieldViewBuilder: formInputBuilder(
        localization.category,
        prefixIcon: selectedCategory == null
          ? null
          : Icon(selectedCategory!.icon, color: selectedCategory!.color),
        suffixIcon: IconButton(
          icon: Icon(Icons.add),
          onPressed: () => NavigatorHelper.pushNamed(
            context,
            RoutesNames.categoriesCreate,
            arguments: 'createMovement',
          ),
        ),
        validator: FormValidatorHelper
          .of(context)
          .isRequired()
          .validator
      ),
      onSelected: _handleCategoryChange,
    );
  }
}
