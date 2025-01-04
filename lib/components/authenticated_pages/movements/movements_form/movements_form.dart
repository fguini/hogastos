import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hogastos/components/authenticated_pages/home/home_layout.dart';
import 'package:hogastos/components/authenticated_pages/movements/movements_form/movements_type_selector/movements_type_selector.dart';
import 'package:hogastos/helpers/form_validator_helper.dart';
import 'package:hogastos/helpers/localization_helper.dart';

const int _movementTextMaxLength = 100;

class MovementsForm extends StatefulWidget {
  final Item? initialMovement;
  final bool isLoading;
  final void Function(Item movement) onSave;

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
  ItemType type = ItemType.computable;
  DateTime date = DateTime.now();
  TextEditingController textController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    if(widget.initialMovement != null) {
      setState(() {
        type = widget.initialMovement!.type;
      });
    }

    super.initState();
  }

  void _handleTypeChange(ItemType newType) {
    setState(() {
      type = newType;
    });
  }

  void _handleDateChange(DateTime newDate) {
    setState(() {
      date = newDate;
    });
  }

  void _handleSave() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    widget.onSave(
      Item(
        textController.text,
        Category(1, 'churrin1', Colors.greenAccent, Icons.church),
        double.tryParse(amountController.text) ?? 0,
        date,
        type,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUnfocus,
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
                    onTypeChange: _handleTypeChange,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: InputDatePickerFormField(
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
                  child: TextFormField(
                    initialValue: widget.initialMovement?.text,
                    decoration: InputDecoration(
                      label: Text(localization.category),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
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
    );
  }
}
