import 'package:flutter/material.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:intl/intl.dart';

class DatePickerInputForm extends StatefulWidget {
  final DateTime? initialValue;
  final bool isLoading;
  final Widget label;
  final void Function(DateTime?) onDateChanged;
  final String? Function(String?) validator;

  const DatePickerInputForm({
    super.key,
    this.initialValue,
    this.isLoading = false,
    required this.label,
    required this.onDateChanged,
    required this.validator,
  });

  @override
  State<DatePickerInputForm> createState() => _DatePickerInputFormState();
}

class _DatePickerInputFormState extends State<DatePickerInputForm> {
  late TextEditingController controller = TextEditingController();

  DateFormat get _dateFormat {
    if(!context.mounted) {
      return DateFormat.yMd();
    }

    var localization = LocalizationHelper.localization(context);

    return DateFormat.yMd(localization.localeName);
  }

  String _getStringFromDateTime(DateTime date)
    => _dateFormat.format(date);

  DateTime _getDateTimeFromString(String date)
    => _dateFormat.parse(date);

  void _updateControllerText(DateTime? date) {
    var newText = date != null
      ? _getStringFromDateTime(date)
      : '';

    setState(() {
      controller.text = newText;
    });
  }

  void _handleDatePicker() {
    var localization = LocalizationHelper.localization(context);

    showDatePicker(
      context: context,
      initialDate: controller.text.isEmpty
          ? DateTime.now()
          : _getDateTimeFromString(controller.text),
      firstDate: DateTime(2000, DateTime.january, 1),
      lastDate: DateTime(2999, DateTime.december, 31),
      locale: Locale(localization.localeName),
    ).then((newDate) {
      if(newDate != null) {
        _updateControllerText(newDate);
        widget.onDateChanged(newDate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(controller.text.isEmpty) {
      controller.text = _getStringFromDateTime(
        widget.initialValue ?? DateTime.now()
      );
    }

    return TextFormField(
      enabled: !widget.isLoading,
      controller: controller,
      decoration: InputDecoration(
        label: widget.label,
        suffixIcon: Icon(Icons.calendar_month),
      ),
      readOnly: true,
      validator: widget.validator,
      onTap: _handleDatePicker,
    );
  }
}
