import 'package:flutter/material.dart';
import 'package:hogastos/components/common/rounded_autocomplete/rounded_autocomplete.dart';
import 'package:hogastos/configurations/routes.dart';
import 'package:hogastos/helpers/form_validator_helper.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/helpers/navigator_helper.dart';
import 'package:hogastos/models/category.dart';
import 'package:hogastos/services/category_service.dart';

class CategorySelector extends StatefulWidget {
  final Category? initialValue;
  final bool isLoading;
  final void Function(Category? category) onCategoryChanged;

  const CategorySelector({
    super.key,
    this.initialValue,
    this.isLoading = false,
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

  String _displayStringForOption(Category? category) =>
    category?.description ?? '';

  Widget _displayWidgetForOption(Category? category) => Row(
    children: category != null ? [
      Icon(category.icon, color: category.color),
      SizedBox(width: 4),
      Text(_displayStringForOption(category)),
    ] : [],
  );

  Future<List<Category>> _buildOptions(TextEditingValue textEditingValue) {
    return CategoryService().getCategoriesByDescription(
      textEditingValue.text
    );
  }

  Widget? _prefixIconBuilder(Category? category) {
    return selectedCategory == null
      ? null
      : Icon(selectedCategory!.icon, color: selectedCategory!.color);
  }

  Widget? _suffixIconBuilder(Category? category) {
    return IconButton(
      icon: Icon(Icons.add),
      onPressed: () => NavigatorHelper.pushNamed(
        context,
        RoutesNames.categoriesCreate,
        arguments: RoutesNames.movementsCreate,
      ),
    );
  }

  void _handleCategoryChange(Category? newCategory) {
    setState(() {
      selectedCategory = newCategory;
    });

    widget.onCategoryChanged(newCategory);
  }

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);

    return RoundedAutocomplete<Category>(
      initialValue: widget.initialValue,
      displayStringForOption: _displayStringForOption,
      displayWidgetForOption: _displayWidgetForOption,
      optionBuilder: _buildOptions,
      label: localization.category,
      isLoading: widget.isLoading,
      inputPrefixIconBuilder: _prefixIconBuilder,
      inputSuffixIconBuilder: _suffixIconBuilder,
      validator: FormValidatorHelper
        .of(context)
        .isRequired()
        .validator,
      onValueChanged: _handleCategoryChange,
    );
  }
}
