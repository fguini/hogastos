import 'package:excel/excel.dart';
import 'package:hogastos/generated/i18n/app_localizations.dart';
import 'package:hogastos/helpers/date_helper.dart';

import 'movement.dart';

enum HeaderKey {
  excelHeaderCategory,
  excelHeaderDate,
  excelHeaderDescription,
  excelHeaderAmount,
}

enum ExcelColumnDefinition {
  category(headerKey: HeaderKey.excelHeaderCategory),
  date(headerKey: HeaderKey.excelHeaderDate),
  description(headerKey: HeaderKey.excelHeaderDescription),
  amount(headerKey: HeaderKey.excelHeaderAmount);

  final HeaderKey headerKey;

  const ExcelColumnDefinition({
    required this.headerKey,
  });

  String getHeaderText(AppLocalizations localization) {
    switch(headerKey) {
      case HeaderKey.excelHeaderCategory:
        return localization.excelHeaderCategory;
      case HeaderKey.excelHeaderDate:
        return localization.excelHeaderDate;
      case HeaderKey.excelHeaderDescription:
        return localization.excelHeaderDescription;
      case HeaderKey.excelHeaderAmount:
        return localization.excelHeaderAmount;
    }
  }

  CellValue getCellValue(Movement movement) {
    switch(headerKey) {
      case HeaderKey.excelHeaderCategory:
        return TextCellValue(movement.category.description);
      case HeaderKey.excelHeaderDate:
        return TextCellValue(getFormattedDate(movement.date));
      case HeaderKey.excelHeaderDescription:
        return TextCellValue(movement.text);
      case HeaderKey.excelHeaderAmount:
        return DoubleCellValue(movement.amount);
    }
  }
}