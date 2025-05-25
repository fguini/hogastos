import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:hogastos/components/authenticated_pages/home/home_date_navigator/month_and_year.dart';
import 'package:hogastos/helpers/color_helper.dart';
import 'package:hogastos/models/movement.dart';
import 'package:hogastos/services/movement_service.dart';
import 'package:path_provider/path_provider.dart';

class ExcelService {
  static const String _defaultSheetName = 'Sheet1';

  Future<Map<MonthAndYear, List<Movement>>> _getMonthAndYearsMovements(
    List<MonthAndYear> monthAndYears
  ) async {
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
    var excel = Excel.createExcel();

    for(var monthAndYear in monthAndYears) {
      excel.copy(_defaultSheetName, monthAndYear.locale(context));
    }

    excel.delete(_defaultSheetName);

    return excel;
  }

  void _fillSheetHeaders(Sheet sheet) {
    sheet.appendRow([
      TextCellValue('Categoria'),
      TextCellValue('Fecha'),
      TextCellValue('Descripción'),
      TextCellValue('Importe'),
    ]);
  }

  void _fillSheetData(Sheet sheet, List<Movement> movements) {
    for (var movement in movements) {
      sheet.appendRow([
        TextCellValue(movement.category.description),
        TextCellValue(movement.date.toString()),
        TextCellValue(movement.text),
        DoubleCellValue(movement.amount),
      ]);

      var fontColorHex = ExcelColor.fromHexString(
        getTextColor(movement.category.color).toHex()
      );
      var backgroundColorHex = ExcelColor.fromHexString(
        movement.category.color.toHex()
      );

      sheet.row(movements.indexOf(movement)).forEach((cell) {
        cell?.cellStyle = CellStyle(
          fontColorHex: fontColorHex,
          backgroundColorHex: backgroundColorHex,
        );
      });
    }
  }

  Future<void> exportToExcel(List<MonthAndYear> monthAndYears, { required BuildContext context }) async {
    Map<MonthAndYear, List<Movement>> sheetsData = await _getMonthAndYearsMovements(monthAndYears);
    var excel = _createExcelWithSheets(monthAndYears, context: context);

    for (var sheetEntry in sheetsData.entries) {
      var sheet = excel[sheetEntry.key.locale(context)];
      _fillSheetHeaders(sheet);
      _fillSheetData(sheet, sheetEntry.value);
    }

    var now = DateTime.now().toString();
    var fileBytes = excel.save();
    var directory = await getDownloadsDirectory();

    File('$directory/hogastos-movimientos-$now.xlsx')
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);
  }
}