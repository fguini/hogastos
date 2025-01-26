import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/movements/movements_form/category_selector/category_selector.dart';
import 'package:hogastos/components/authenticated_pages/movements/movements_form/movements_income_expense_selector/income_expense.dart';
import 'package:hogastos/components/authenticated_pages/movements/movements_form/movements_type_selector/movements_type_selector.dart';
import 'package:hogastos/components/common/error_elevated_button.dart';
import 'package:hogastos/helpers/form_validator_helper.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/helpers/widget_helper.dart';
import 'package:hogastos/models/category.dart';
import 'package:hogastos/models/create_movement.dart';
import 'package:hogastos/models/movement.dart';
import 'package:hogastos/models/movement_type.dart';

import 'movements_income_expense_selector/movements_income_expense_selector.dart';

const int _movementTextMaxLength = 100;

class MovementsForm extends StatefulWidget {
  final Movement? initialMovement;
  final Category? preselectedCategory;
  final bool isLoading;
  final void Function(int)? onDelete;
  final void Function(CreateMovement movement) onSave;

  const MovementsForm({
    super.key,
    this.initialMovement,
    this.preselectedCategory,
    this.isLoading = false,
    this.onDelete,
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
  IncomeExpense incomeExpense = IncomeExpense(IncomeExpenseType.expense);
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    if(widget.initialMovement != null) {
      var movement = widget.initialMovement!;

      textController.text = movement.text;
      amountController.text = movement.amount.abs().toString();

      setState(() {
        type = movement.type;
        date = movement.date;
        category = movement.category;
        incomeExpense = IncomeExpense(
          movement.amount > 0
            ? IncomeExpenseType.income
            : IncomeExpenseType.expense
        );
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

  void _handleIncomeExpenseChange(IncomeExpense newIncomeExpense) {
    setState(() {
      incomeExpense = newIncomeExpense;
    });
  }

  void _handleSave() {
    var isFormValid = _formKey.currentState?.validate() ?? false;
    var isDateEmpty = date == null;
    var isCategoryEmpty = category == null;

    if (!isFormValid || isDateEmpty || isCategoryEmpty) {
      return;
    }
    var amount = incomeExpense.getAmount(
      double.tryParse(amountController.text) ?? 0
    );

    var newMovement = widget.initialMovement == null
      ? CreateMovement(
        textController.text,
        category!,
        amount,
        date!,
        type,
      )
      : Movement(
        widget.initialMovement!.id,
        textController.text,
        category!,
        amount,
        date!,
        type,
      );

    widget.onSave(newMovement);
  }

  void _handleDelete() {
    widget.onDelete!(widget.initialMovement!.id);
  }

  @override
  void didUpdateWidget(covariant MovementsForm oldWidget) {
    if(oldWidget.preselectedCategory?.id != widget.preselectedCategory?.id) {
      setState(() {
        category = widget.preselectedCategory;
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);

    var disabledFocusNode = FocusNode();
    disabledFocusNode.canRequestFocus = false;

    var areWeEditing = widget.initialMovement?.id != null;

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
                    padding: const EdgeInsets.only(top: 10),
                    child: MovementsIncomeExpenseSelector(
                      selectedType: incomeExpense,
                      isLoading: widget.isLoading,
                      onTypeChange: _handleIncomeExpenseChange,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      enabled: !widget.isLoading,
                      controller: amountController,
                      decoration: InputDecoration(
                        label: Text(localization.movementAmount),
                        prefixIcon: Icon(
                          incomeExpense.type == IncomeExpenseType.expense
                            ? Icons.remove
                            : Icons.add
                        ),
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
