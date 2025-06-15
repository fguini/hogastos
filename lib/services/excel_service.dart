import 'dart:typed_data';
import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:hogastos/components/authenticated_pages/home/home_date_navigator/month_and_year.dart';
import 'package:hogastos/helpers/color_helper.dart';
import 'package:hogastos/helpers/date_helper.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/models/movement.dart';
import 'package:hogastos/services/movement_service.dart';

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

    sheet.appendRow([
      TextCellValue(localization.excelHeaderId),
      TextCellValue(localization.excelHeaderCategory),
      TextCellValue(localization.excelHeaderDate),
      TextCellValue(localization.excelHeaderDescription),
      TextCellValue(localization.excelHeaderAmount),
    ]);
  }

  void _fillSheetData(Sheet sheet, List<Movement> movements) {
    for (var movement in movements) {
      sheet.appendRow([
        IntCellValue(movement.id),
        TextCellValue(movement.category.description),
        TextCellValue(getFormattedDate(movement.date)),
        TextCellValue(movement.text),
        DoubleCellValue(movement.amount),
      ]);

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
}