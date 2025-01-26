import 'package:flutter/material.dart';
import 'package:hogastos/components/common/error_elevated_button.dart';
import 'package:hogastos/helpers/form_validator_helper.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/helpers/widget_helper.dart';
import 'package:hogastos/models/category.dart';
import 'package:hogastos/models/create_category.dart';

import 'color_selector/color_selector.dart';
import 'icon_selector/icon_selector.dart';

const int _categoryDescriptionMaxLength = 100;

class CategoriesForm extends StatefulWidget {
  final Category? initialCategory;
  final bool isLoading;
  final void Function(int)? onDelete;
  final void Function(CreateCategory) onSave;

  const CategoriesForm({
    super.key,
    this.initialCategory,
    required this.isLoading,
    this.onDelete,
    required this.onSave,
  });

  @override
  State<CategoriesForm> createState() => _CategoriesFormState();
}

class _CategoriesFormState extends State<CategoriesForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();
  Color? color;
  IconData? icon;

  @override
  void initState() {
    if(widget.initialCategory != null) {
      var category = widget.initialCategory!;

      descriptionController.text = category.description;

      setState(() {
        color = category.color;
        icon = category.icon;
      });
    }

    super.initState();
  }

  void _handleColorChange(Color newColor) {
    setState(() {
      color = newColor;
    });
  }

  void _handleIconChange(IconData? newIcon) {
    setState(() {
      icon = newIcon;
    });
  }

  void _handleSave() {
    var isFormValid = _formKey.currentState?.validate() ?? false;
    var isColorEmpty = color == null;
    var isIconEmpty = icon == null;

    if(!isFormValid || isColorEmpty || isIconEmpty) {
      return;
    }

    var newCategory = widget.initialCategory == null
      ? CreateCategory(
        descriptionController.text,
        color!,
        icon!,
      )
      : Category(
        widget.initialCategory!.id,
        descriptionController.text,
        color!,
        icon!,
      );

    widget.onSave(newCategory);
  }

  void _handleDelete() {
    widget.onDelete!(widget.initialCategory!.id);
  }

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);
    var areWeEditing = widget.initialCategory?.id != null;

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUnfocus,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      enabled: !widget.isLoading,
                      controller: descriptionController,
                      decoration: InputDecoration(
                        label: Text(localization.movementText),
                      ),
                      validator: FormValidatorHelper
                        .of(context)
                        .isRequired()
                        .maxLength(_categoryDescriptionMaxLength)
                        .validator,
                    ),
                  ),
                  ColorSelector(
                    selectedColor: color,
                    enabled: !widget.isLoading,
                    onChanged: _handleColorChange,
                  ),
                  SizedBox(height: 12),
                  IconSelector(
                    selectedIcon: icon,
                    enabled: !widget.isLoading,
                    onChanged: _handleIconChange,
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleSave,
                  child: Text(
                    !areWeEditing
                      ? localization.actionsCreate
                      : localization.actionsSave
                  ),
                ),
              ),
              ...WidgetHelper.conditionalWidgetToSpread(
                areWeEditing,
                SizedBox(
                  width: double.infinity,
                  child: ErrorElevatedButton(
                    onPressed: _handleDelete,
                    child: Text(localization.actionsDelete),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
