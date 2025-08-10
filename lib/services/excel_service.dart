import 'dart:io';
import 'dart:typed_data';
import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:hogastos/components/authenticated_pages/files/import_column_selector/column_selection.dart';
import 'package:hogastos/models/dates/month_and_year.dart';
import 'package:hogastos/helpers/color_helper.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/models/category.dart';
import 'package:hogastos/models/create_movement.dart';
import 'package:hogastos/models/excel_column_definition.dart';
import 'package:hogastos/models/excel_import_brief.dart';
import 'package:hogastos/models/movement.dart';
import 'package:hogastos/models/movement_type.dart';
import 'package:hogastos/services/category_service.dart';
import 'package:hogastos/services/movement_service.dart';
import 'package:intl/intl.dart';

class ExcelService {
  static const String _defaultSheetName = 'Sheet1';
  static const String _defaultFileNamePrefix = 'hogastos';

  void throwIfUnmounted(BuildContext context) {
    if(!context.mounted) {
      throw Exception('Operation cancelled');
    }
  }

  Future<Map<MonthAndYear, List<Movement>>> _getMonthAndYearsMovements(List<MonthAndYear> monthAndYears) async {
    Map<MonthAndYear, List<Movement>> monthAndYearsMovements = {};

    for(var monthAndYear in monthAndYears) {
      monthAndYearsMovements[monthAndYear] = await MovementService().getByMonthAndYear(
          monthAndYear.monthNumber,
          monthAndYear.year
      );
    }

    return monthAndYearsMovements;
  }

  Excel _createExcelWithSheets(List<MonthAndYear> monthAndYears, { required BuildContext context }) {
    throwIfUnmounted(context);

    var excel = Excel.createExcel();

    for(var monthAndYear in monthAndYears) {
      excel.copy(_defaultSheetName, monthAndYear.locale(context));
    }

    excel.delete(_defaultSheetName);

    return excel;
  }

  void _fillSheetHeaders(Sheet sheet, { required BuildContext context }) {
    throwIfUnmounted(context);

    var localization = LocalizationHelper.localization(context);

    sheet.appendRow(
      ExcelColumnDefinition
        .values
        .map((columnDefinition) => TextCellValue(
          columnDefinition.getHeaderText(localization)
        ))
        .toList()
    );
  }

  void _fillSheetData(Sheet sheet, List<Movement> movements) {
    for (var movement in movements) {
      sheet.appendRow(
        ExcelColumnDefinition
          .values
          .map((columnDefinition) => columnDefinition.getCellValue(movement))
          .toList()
      );

      var fontColorHex = ExcelColor.fromHexString(
        getTextColor(movement.category.color).toHex()
      );
      var backgroundColorHex = ExcelColor.fromHexString(
        movement.category.color.toHex()
      );

      sheet.row(movements.indexOf(movement) + 1).forEach((cell) {
        cell?.cellStyle = CellStyle(
          fontColorHex: fontColorHex,
          backgroundColorHex: backgroundColorHex,
        );
      });
    }
  }

  Future<void> _createDownloadAndOpenFile(Excel excel) async {
    var now = DateTime.now().toString();
    var fileName = '$_defaultFileNamePrefix-$now.xlsx';
    var fileBytes = excel.save(fileName: fileName);
    var fileData = fileBytes == null
      ? null
      : Uint8List.fromList(fileBytes);

    await FlutterFileDialog.saveFile(
      params: SaveFileDialogParams(
        data: fileData,
        fileName: fileName,
      ),
    );
  }

  Future<void> exportToExcel(List<MonthAndYear> monthAndYears, { required BuildContext context }) async {
    Map<MonthAndYear, List<Movement>> sheetsData = await _getMonthAndYearsMovements(monthAndYears);
    var excel = _createExcelWithSheets(monthAndYears, context: context);

    for (var sheetEntry in sheetsData.entries) {
      var sheet = excel[sheetEntry.key.locale(context)];
      _fillSheetHeaders(sheet, context: context);
      _fillSheetData(sheet, sheetEntry.value);
    }

    throwIfUnmounted(context);

    await _createDownloadAndOpenFile(excel);
  }

  Excel _openExcelFile(String path) {
    var file = File(path).readAsBytesSync();
    return Excel.decodeBytes(file);
  }

  Future<ExcelImportBrief> pickFileAndOpen() async {
    var path = await FlutterFileDialog.pickFile(params: OpenFileDialogParams(
      dialogType: OpenFileDialogType.document,
      fileExtensionsFilter: [ 'xlsx' ],
    ));

    if(path == null) {
      throw Exception('Error abriendo el archivo');
    }

    var excel = _openExcelFile(path);

    return ExcelImportBrief.fromExcel(path, excel);
  }

  CellValue? _getCellValueByColumnDefinition({
    required Sheet excelTable,
    required ColumnSelection columnSelections,
    required ExcelColumnDefinition columnDefinition,
    required int rowIndex,
  }) {
    var columnIndex = columnSelections.getColumnIndexByColumnDefinition(columnDefinition);
    var cell = excelTable.cell(
        CellIndex.indexByColumnRow(
          columnIndex: int.parse(columnIndex),
          rowIndex: rowIndex
        )
    );

    return cell.value;
  }

  Category _getCategoryByRow({
    required Sheet excelTable,
    required ColumnSelection columnSelections,
    required List<Category> currentCategories,
    required HeaderKey key,
    required int rowIndex,
  }) {
    var categoryCellValue = _getCellValueByColumnDefinition(
      excelTable: excelTable,
      columnSelections: columnSelections,
      columnDefinition: ExcelColumnDefinition.category,
      rowIndex: rowIndex
    ) as TextCellValue;
    var categoryDescription = categoryCellValue.value.text?.toString().trim() ?? '';

    var currentCategory = currentCategories.where(
      (c) => c.description.toLowerCase().trim() == categoryDescription.toLowerCase()
    ).firstOrNull;

    return currentCategory ?? Category.fromDescription(categoryDescription);
  }

  CreateMovement _getMovementByRow({
    required Sheet excelTable,
    required ColumnSelection columnSelections,
    required String locale,
    required int rowIndex,
    required Category category,
  }) {
    var descriptionValue = _getCellValueByColumnDefinition(
      excelTable: excelTable,
      columnSelections: columnSelections,
      columnDefinition: ExcelColumnDefinition.description,
      rowIndex: rowIndex
    ) as TextCellValue;
    var amountValue = _getCellValueByColumnDefinition(
      excelTable: excelTable,
      columnSelections: columnSelections,
      columnDefinition: ExcelColumnDefinition.amount,
      rowIndex: rowIndex
    );
    var dateValue = _getCellValueByColumnDefinition(
      excelTable: excelTable,
      columnSelections: columnSelections,
      columnDefinition: ExcelColumnDefinition.date,
      rowIndex: rowIndex
    );

    DateFormat format = DateFormat.yMd(locale);

    return CreateMovement(
      descriptionValue.value.text ?? '',
      category,
      double.parse(amountValue.toString()),
      dateValue is DateCellValue
        ? dateValue.asDateTimeLocal()
        : format.parse(dateValue.toString()),
      MovementType.computable,
    );
  }

  Future<(List<CreateMovement>, List<Category>)> getMovementsAndCategoriesFromExcel(
    ExcelImportBrief file,
    Map<String, ColumnSelection> columnSelection,
    String locale,
  ) async {
    List<CreateMovement> movements = [];
    List<Category> categories = [];

    var currentCategories = await CategoryService().getAll();

    var excel = _openExcelFile(file.path);

    for(var table in columnSelection.keys) {
      var excelTable = excel.tables[table]!;
      var columnSelections = columnSelection[table]!;
      var firstRow = columnSelections.hasHeadersRow ? 1 : 0;

      for(var rowIndex = firstRow; rowIndex < excelTable.maxRows; rowIndex++) {
        var category = _getCategoryByRow(
          excelTable: excelTable,
          currentCategories: currentCategories,
          columnSelections: columnSelections,
          key: HeaderKey.excelHeaderCategory,
          rowIndex: rowIndex
        );


        if(categories.every((c) => c.description != category.description)) {
          categories.add(category);
        }

        movements.add(
          _getMovementByRow(
            excelTable: excelTable,
            columnSelections: columnSelections,
            locale: locale,
            category: category,
            rowIndex: rowIndex,
          ),
        );
      }
    }

    return (movements, categories);
  }

  Future<void> import(List<CreateMovement> movements, List<Category> categories) async {
    var categoriesToBeCreated = categories.where((c) => c.id == 0).toList();
    var createdCategories = await CategoryService().createCategories(categoriesToBeCreated);

    var movementsToBeCreated = movements.map((movement) {
      if(movement.category.id != 0) return movement;

      var category = createdCategories.firstWhere(
        (c) => c.description == movement.category.description
      );

      return CreateMovement(
        movement.text,
        category,
        movement.amount,
        movement.date,
        movement.type,
      );
    }).toList();

    MovementService().createMovements(movementsToBeCreated);

    return Future.delayed(Duration(seconds: 1));
  }
}