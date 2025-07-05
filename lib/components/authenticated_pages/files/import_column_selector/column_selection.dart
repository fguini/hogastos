import 'package:hogastos/models/excel_column_definition.dart';

class ColumnSelection {
  bool hasHeadersRow;
  Map<String, ExcelColumnDefinition?> columnSelection;

  ColumnSelection({
    required this.hasHeadersRow,
    required this.columnSelection,
  });

  String getColumnIndexByColumnDefinition(ExcelColumnDefinition columnDefinition) {
    var columnDefinitions = columnSelection.values.toList();
    var index = columnDefinitions.indexWhere((cd) => cd == columnDefinition);

    return columnSelection.keys.elementAt(index);
  }
}