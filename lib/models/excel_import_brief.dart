import 'package:excel/excel.dart';

class SheetStats {
  List<String> list = [];

  void add(String sheet) {
    list.add(sheet);
  }

  get count => list.length;
}

class RowStats {
  Map<String, List<String>> listPerSheet = {};

  void add(String sheet, String row) {
    listPerSheet[sheet] ??= [];

    listPerSheet[sheet]!.add(row);
  }

  get count => listPerSheet.values
    .map((rows) => rows.length)
    .reduce((count, sheetCount) => count + sheetCount);
}

class ColumnData {
  final String sheetName;
  final String columnName;
  final CellValue? columnValue;

  const ColumnData({
    required this.sheetName,
    required this.columnName,
    required this.columnValue,
  });
}

class ColumnStats {
  List<ColumnData> columnsAvailable = [];

  void add(String sheetName, String columnName, CellValue? columnValue) {
    var exist = columnsAvailable.where(
      (c) => c.sheetName == sheetName && c.columnName == columnName
    );

    if(exist.isNotEmpty) return;

    columnsAvailable.add(
      ColumnData(
        sheetName: sheetName,
        columnName: columnName,
        columnValue: columnValue,
      ),
    );
  }

  get count => columnsAvailable.length;
}

class ExcelImportBrief {
  final String path;
  final SheetStats sheets;
  final RowStats rows;
  final ColumnStats columns;

  ExcelImportBrief({
    required this.path,
    required this.sheets,
    required this.rows,
    required this.columns,
  });

  factory ExcelImportBrief.fromExcel(String path, Excel excel) {
    var brief = ExcelImportBrief(
      path: path,
      sheets: SheetStats(),
      rows: RowStats(),
      columns: ColumnStats(),
    );

    for (var table in excel.tables.keys) {
      brief.sheets.add(table);

      if(excel.tables[table] == null) continue;

      for (var row in excel.tables[table]!.rows) {
        brief.rows.add(table, excel.tables[table]!.rows.indexOf(row).toString());

        for (var cell in row) {
          if(cell == null) continue;

          brief.columns.add(
            table,
            cell.columnIndex.toString(),
            cell.value,
          );
        }
      }
    }

    return brief;
  }
}