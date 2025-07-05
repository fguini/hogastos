import 'package:flutter/material.dart';
import 'package:hogastos/components/animations/dialog_transition.dart';
import 'package:hogastos/components/authenticated_pages/files/import_column_selector/column_data_selector_dialog.dart';
import 'package:hogastos/components/common/rounded_list_tile.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/models/excel_column_definition.dart';

class ColumnDataSelector extends StatelessWidget {
  final Map<String, ExcelColumnDefinition?> columnSelection;
  final void Function(Map<String, ExcelColumnDefinition?>) onColumnSelectionChanged;

  const ColumnDataSelector({
    super.key,
    required this.columnSelection,
    required this.onColumnSelectionChanged,
  });

  VoidCallback _getHandleCloseDialog(BuildContext context)
    => () => Navigator.of(context).pop();

  HandleColumnChanged _getHandleColumnChanged(VoidCallback onClose)
    => (String columnIndex, ExcelColumnDefinition? columnDefinition) {
      var currentValue = columnSelection[columnIndex];
      var hasChanged = currentValue != columnDefinition;

      if(hasChanged) {
        var definitionAssignedTo = columnSelection
          .keys
          .where((columnIndex) => columnSelection[columnIndex] == columnDefinition)
          .firstOrNull;

        Map<String, ExcelColumnDefinition?> newColumnSelection = {
          ...columnSelection,
          columnIndex: columnDefinition,
        };

        if(definitionAssignedTo != null) {
          newColumnSelection[definitionAssignedTo] = currentValue;
        }

        onColumnSelectionChanged(newColumnSelection);
      }

      onClose();
    };

  void _handleColumnTap(BuildContext context, String columnIndex) {
    var handleClose = _getHandleCloseDialog(context);
    var handleColumnChanged = _getHandleColumnChanged(handleClose);

    DialogTransition.open(
      context,
      ColumnDataSelectorDialog(
        columnIndex: columnIndex,
        columnDefinition: columnSelection[columnIndex],
        showUnassigned: columnSelection.keys.length > ExcelColumnDefinition.values.length,
        onClose: handleClose,
        onColumnChanged: handleColumnChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);
    
    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: columnSelection.keys.map((columnIndex) => RoundedListTile(
            title: localization.alphabet[int.parse(columnIndex)],
            trailing: BodyText(
              columnSelection[columnIndex]?.getHeaderText(localization)
                ?? localization.importFromExcelColumnNotAssigned,
            ),
            onTap: () => _handleColumnTap(context, columnIndex),
          )).toList(),
        ),
      ),
    );
  }
}
