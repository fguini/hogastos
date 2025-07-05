import 'package:flutter/material.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:hogastos/components/texts/title_text.dart';
import 'package:hogastos/generated/i18n/app_localizations.dart';
import 'package:hogastos/helpers/color_helper.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/models/excel_column_definition.dart';

typedef HandleColumnChanged = void Function(String, ExcelColumnDefinition?);

class ColumnDataSelectorDialog extends StatefulWidget {
  final String columnIndex;
  final ExcelColumnDefinition? columnDefinition;
  final bool showUnassigned;
  final VoidCallback onClose;
  final HandleColumnChanged onColumnChanged;

  const ColumnDataSelectorDialog({
    super.key,
    required this.columnIndex,
    required this.columnDefinition,
    required this.showUnassigned,
    required this.onClose,
    required this.onColumnChanged,
  });

  @override
  State<ColumnDataSelectorDialog> createState() => _ColumnDataSelectorDialogState();
}

class _ColumnDataSelectorDialogState extends State<ColumnDataSelectorDialog> {
  ExcelColumnDefinition? _selectedColumnDefinition;

  @override
  void initState() {
    _selectedColumnDefinition = widget.columnDefinition;

    super.initState();
  }

  List<ExcelColumnDefinition?> _getColumnDefinitionsList() {
    var values = <ExcelColumnDefinition?>[];

    if(widget.showUnassigned) {
      values.add(null);
    }

    return [
      ...values,
      ...ExcelColumnDefinition.values,
    ];
  }

  void handleValueChanged(ExcelColumnDefinition? newValue) => setState(() {
    _selectedColumnDefinition = newValue;
  });

  String _getColumnDefinitionText(
    AppLocalizations localization,
    ExcelColumnDefinition? columnDefinition,
  ) => columnDefinition?.getHeaderText(localization)
    ?? localization.importFromExcelColumnNotAssigned;

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);
    var theme = Theme.of(context);

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleText(
              localization.importFromExcelColumnTitle(
                localization.alphabet[int.parse(widget.columnIndex)],
              ),
            ),
            SizedBox(height: 20),
            ..._getColumnDefinitionsList().map((columnDefinition) => RadioListTile<ExcelColumnDefinition?>(
              title: BodyText(_getColumnDefinitionText(localization, columnDefinition)),
              value: columnDefinition,
              groupValue: _selectedColumnDefinition,
              onChanged: handleValueChanged,
            )),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.onClose,
                    child: BodyText(localization.actionsBack),
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => widget.onColumnChanged(
                      widget.columnIndex,
                      _selectedColumnDefinition,
                    ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(theme.primaryColor),
                      side: WidgetStateProperty.all(
                        BorderSide(color: theme.primaryColorDark),
                      ),
                    ),
                    child: BodyText(
                      localization.actionsSave,
                      color: getTextColor(theme.primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
