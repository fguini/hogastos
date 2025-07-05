import 'package:excel/excel.dart';

class ColumnData {
  final String columnName;
  final CellValue? columnValue;

  const ColumnData({
    required this.columnName,
    required this.columnValue,
  });
}

class TableStats {
  final String tableName;
  final List<ColumnData> columns;
  final List<String> rows;

  TableStats({
    required this.tableName,
    required this.columns,
    required this.rows,
  });
}

class ExcelImportBrief {
  final String path;
  final List<TableStats> tables;

  ExcelImportBrief({
    required this.path,
    required this.tables,
  });

  static List<String> _getTableRows(Excel excel, String table) {
    List<String> rows = [];

    for (var row in excel.tables[table]!.rows) {
      rows.add(excel.tables[table]!.rows.indexOf(row).toString());
    }

    return rows;
  }

  static List<ColumnData> _getTableColumns(Excel excel, String table) {
    List<ColumnData> columns = [];

    var rowQuantity = excel.tables[table]!.rows.length;
    var rowIndex = rowQuantity > 1 ? 1 : 0;

    for (var cell in excel.tables[table]!.rows[rowIndex]) {
      if(cell == null) continue;

      columns.add(
        ColumnData(
          columnName: cell.columnIndex.toString(),
          columnValue: cell.value,
        ),
      );
    }

    return columns;
  }

  factory ExcelImportBrief.fromExcel(String path, Excel excel) {
    List<TableStats> tables = [];

    for (var table in excel.tables.keys) {
      if(excel.tables[table] == null) continue;

      tables.add(
        TableStats(
          tableName: table,
          rows: _getTableRows(excel, table),
          columns: _getTableColumns(excel, table),
        ),
      );
    }

    return ExcelImportBrief(path: path, tables: tables);
  }
}