import 'package:flutter/material.dart';
import 'package:hogastos/generated/i18n/app_localizations.dart';
import 'package:hogastos/models/utils/serializable.dart';

import 'navigable_date.dart';

enum Month {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december,
}

class MonthAndYear extends NavigableDate implements JsonConvert<MonthAndYear> {
  Month month;
  int year;

  MonthAndYear({
    required this.month,
    required this.year
  });

  factory MonthAndYear.fromMonthAndYear(int month, int year) {
    return MonthAndYear(month: Month.values[month - 1], year: year);
  }

  factory MonthAndYear.fromDate(DateTime date) {
    var month = date.month;
    var year = date.year;

    return MonthAndYear(month: Month.values[month - 1], year: year);
  }

  factory MonthAndYear.now() {
    return MonthAndYear.fromDate(DateTime.now());
  }

  int get _monthIndex => Month.values.indexOf(month);
  int get monthNumber => _monthIndex + 1;

  @override
  String locale(BuildContext context) {
    return AppLocalizations.of(context)!.monthAndYear(
      DateTime(year, _monthIndex + 1),
      year
    );
  }

  @override
  bool equals(NavigableDate other) {
    var theOther = other as MonthAndYear;

    return theOther.month == month && theOther.year == year;
  }
  bool isFutureThan(MonthAndYear other) => other.year < year || (
    other.year == year && other.monthNumber < monthNumber
  );

  @override
  MonthAndYear getPrevious() {
    if(_monthIndex == 0) {
      return MonthAndYear(
        month: Month.december,
        year: year - 1,
      );
    }

    return MonthAndYear(
      month: Month.values[_monthIndex - 1],
      year: year,
    );
  }

  @override
  MonthAndYear getNext() {
    if(month == Month.december) {
      return MonthAndYear(
        month: Month.january,
        year: year + 1,
      );
    }

    return MonthAndYear(
      month: Month.values[_monthIndex + 1],
      year: year,
    );
  }

  factory MonthAndYear.fromJson(Map<String, dynamic> json) {
    return MonthAndYear(
      month: Month.values[json['month']],
      year: json['year'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'month': _monthIndex,
      'year': year,
    };
  }
}