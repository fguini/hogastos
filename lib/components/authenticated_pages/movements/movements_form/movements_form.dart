import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/movements/movements_form/category_selector/category_selector.dart';
import 'package:hogastos/components/authenticated_pages/movements/movements_form/movements_type_selector/movements_type_selector.dart';
import 'package:hogastos/helpers/form_validator_helper.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/models/category.dart';
import 'package:hogastos/models/create_movement.dart';
import 'package:hogastos/models/movement.dart';
import 'package:hogastos/models/movement_type.dart';

const int _movementTextMaxLength = 100;

class MovementsForm extends StatefulWidget {
  final Movement? initialMovement;
  final bool isLoading;
  final void Function(CreateMovement movement) onSave;

  const MovementsForm({
    super.key,
    this.initialMovement,
    this.isLoading = false,
    required this.onSave,
  });

  @override
  State<MovementsForm> createState() => _MovementsFormState();
}

class _MovementsFormState extends State<MovementsForm> {
  final _formKey = GlobalKey<FormState>();
  MovementType type = MovementType.computable;
  DateTime? date = DateTime.now();
  TextEditingController textController = TextEditingController();
  Category? category;
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    if(widget.initialMovement != null) {
      setState(() {
        type = widget.initialMovement!.type;
        date = widget.initialMovement!.date;
        category = widget.initialMovement!.category;
      });
    }

    super.initState();
  }

  void _handleTypeChange(MovementType newType) {
    setState(() {
      type = newType;
    });
  }

  void _handleDateChange(DateTime newDate) {
    setState(() {
      date = newDate;
    });
  }

  void _handleCategoryChange(Category newCategory) {
    setState(() {
      category = newCategory;
    });
  }

  void _handleSave() {
    var isFormValid = _formKey.currentState?.validate() ?? false;
    var isDateEmpty = date == null;
    var isCategoryEmpty = category == null;

    if (!isFormValid || isDateEmpty || isCategoryEmpty) {
      return;
    }

    var newMovement = widget.initialMovement == null
      ? CreateMovement(
        textController.text,
        category!,
        double.tryParse(amountController.text) ?? 0,
        date!,
        type,
      )
      : Movement(
        widget.initialMovement!.id,
        textController.text,
        category!,
        double.tryParse(amountController.text) ?? 0,
        date!,
        type,
      );

    widget.onSave(newMovement);
  }

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);
    var disabledFocusNode = FocusNode();
    disabledFocusNode.canRequestFocus = false;

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
                    padding: const EdgeInsets.only(bottom: 10),
                    child: MovementsTypeSelector(
                      selectedType: type,
                      isLoading: widget.isLoading,
                      onTypeChange: _handleTypeChange,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: InputDatePickerFormField(
                      focusNode: widget.isLoading ? disabledFocusNode : null,
                      initialDate: widget.initialMovement?.date ?? DateTime.now(),
                      firstDate: DateTime(2000, DateTime.january, 1),
                      lastDate: DateTime(2999, DateTime.december, 31),
                      fieldLabelText: localization.movementDate,
                      errorFormatText: localization.validationsWrongFormat,
                      errorInvalidText: localization.validationsNotInRange,
                      onDateSubmitted: _handleDateChange,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      enabled: !widget.isLoading,
                      initialValue: widget.initialMovement?.text,
                      controller: textController,
                      decoration: InputDecoration(
                        label: Text(localization.movementText),
                      ),
                      validator: FormValidatorHelper
                        .of(context)
                        .isRequired()
                        .maxLength(_movementTextMaxLength)
                        .validator,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CategorySelector(
                      initialValue: widget.initialMovement?.category,
                      isLoading: widget.isLoading,
                      onCategoryChanged: _handleCategoryChange,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      enabled: !widget.isLoading,
                      initialValue: widget.initialMovement?.text,
                      controller: amountController,
                      decoration: InputDecoration(
                        label: Text(localization.movementAmount),
                        suffixText: LocalizationHelper.getCurrencySymbol(context),
                        suffixStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                        signed: true,
                        decimal: true,
                      ),
                      validator: FormValidatorHelper
                        .of(context)
                        .isRequired()
                        .isFormatRequired(FormValidatorHelper.isAmountValueValid)
                        .validator,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleSave,
                  child: Text(localization.actionsCreate),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
